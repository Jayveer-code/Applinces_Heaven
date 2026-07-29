from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, get_object_or_404, redirect
from store.models import Product, Categories, Filter_Price, Profile, contact_us, Order, Orderitem, SubCategories, EmailOTP, Review, Wishlist, Coupon, UserActivity
from django.contrib.auth.models import User
from django.contrib import auth, messages
from django.contrib.auth.decorators import login_required
from cart.cart import Cart
import razorpay
from django.views.decorators.csrf import csrf_exempt
from django.utils import timezone
from datetime import timedelta
from django.core.mail import send_mail
from django.conf import settings
from django.db.models import Avg, Count, Q
from django.db import models
import random
from decimal import Decimal


def Main(request):
    product = Product.objects.filter(status='PUBLISH')[:8]
    # Deal of the Day — active deals only
    deal_products = Product.objects.filter(
        status='PUBLISH',
        is_deal_of_day=True,
        discount_percentage__gt=0,
    ).filter(
        Q(offer_expiry__isnull=True) | Q(offer_expiry__gt=timezone.now())
    )[:6]
    context = {
        'product': product,
        'deal_products': deal_products,
    }
    return render(request, 'index.html', context)

def LoginPage(request):
    return render(request,'login.html')

def invoice_page(request):
    o_id=request.POST['o_id']
    order_obj=Order.objects.get(id=o_id)
    order_item=Orderitem.objects.filter(order_id=order_obj)
    customer_id = request.user.id
    customer_obj=User.objects.get(id=customer_id)
    profile_obj=Profile.objects.get(user_id=customer_obj)
    return render(request,"invoice.html",{'customer_obj':customer_obj,'profile_obj':profile_obj,'order_obj':order_obj,'order_item':order_item})

def CartPage(request):
    return render(request,'cart.html')


def CheckoutPage(request):
    user_id = request.user.id
    # Use get_or_create to avoid DoesNotExist error if profile was not created during registration
    profile, created = Profile.objects.get_or_create(
        user_id=user_id,
        defaults={'contact': 0, 'address': '', 'gender': 'Not Specified'}
    )

    # ── Compute discounted cart total ────────────────────────────
    cart = request.session.get('cart', {})
    cart_subtotal = Decimal('0')
    for key, value in cart.items():
        try:
            product = Product.objects.get(id=value['product_id'])
            unit_price = Decimal(str(product.get_discounted_price()))
        except Exception:
            unit_price = Decimal(str(value.get('price', 0)))
        cart_subtotal += unit_price * int(value.get('quantity', 1))

    # ── Coupon discount ──────────────────────────────────────
    coupon_discount = Decimal(str(request.session.get('coupon_discount', '0')))
    coupon_code = request.session.get('coupon_code', '')
    
    amount_after_coupon = cart_subtotal - coupon_discount
    gst_amount = amount_after_coupon * Decimal('0.18')
    delivery_charge = Decimal('80.00') if amount_after_coupon > 0 else Decimal('0.00')
    final_total = amount_after_coupon + gst_amount + delivery_charge

    context = {
        'profile': profile,
        'cart_subtotal': cart_subtotal,
        'coupon_discount': coupon_discount,
        'coupon_code': coupon_code,
        'gst_amount': gst_amount,
        'delivery_charge': delivery_charge,
        'final_total': final_total,
    }
    return render(request, 'checkout.html', context)

def ContactPage(request):
    if request.method=='POST':
        name=request.POST.get('name')
        email=request.POST.get('email')
        subject=request.POST.get('subject')
        message=request.POST.get('message')

        contact=contact_us(
            name=name,
            email=email,
            subject=subject,
            message=message,
        )
        contact.save()
        return redirect('/')
    return render(request,'contact.html')

def AboutPage(request):
    return render(request,'about.html')

def ForgotPage(request):
    return render(request,'forgot.html')

def registration(request):
    return render(request,'registrations.html')

def placeorder(request):
    if request.method == "POST":
        uid=request.user.id
        myuser=User.objects.get(id=uid)
        cart=request.session.get('cart')
        myfirstname=request.POST.get('firstname')
        mylastname =request.POST.get('lastname')
        mydob=request.POST.get('dob')
        mystate=request.POST.get('state')
        myaddress=request.POST.get('address')
        mycity=request.POST.get('city')
        mypincode=request.POST.get('pincode')
        myamount=request.POST.get('amount')   # comes from hidden input in checkout
        myphone=request.POST.get('phone')
        myemail=request.POST.get('email')
        order_id=request.POST.get('order_id')
        mypayment_method=request.POST.get('payment')
        order=Order.objects.create(
            user=myuser, firstname=myfirstname, lastname=mylastname,
            orderdate=mydob, state=mystate, address=myaddress,
            city=mycity, pincode=mypincode, amount=myamount,
            phone=myphone, email=myemail,
            payment_id=order_id, payment_method=mypayment_method
        )
        for i in cart:
            try:
                product = Product.objects.get(id=cart[i]['product_id'])
                # Deduct stock
                qty_ordered = int(cart[i]['quantity'])
                product.stock = max(0, product.stock - qty_ordered)
                product.save()
                
                unit_price = float(product.get_discounted_price())
            except Exception:
                unit_price = float(cart[i]['price'])
            total = unit_price * int(cart[i]['quantity'])
            item = Orderitem(
                order=order,
                product=cart[i]['name'],
                image=cart[i]['image'],
                quantity=cart[i]['quantity'],
                price=unit_price,
                total=total,
            )
            item.save()

        # Increment coupon usage if coupon was applied
        coupon_code = request.session.get('coupon_code', '')
        if coupon_code:
            try:
                coupon = Coupon.objects.get(code=coupon_code.upper())
                coupon.times_used += 1
                coupon.save()
            except Coupon.DoesNotExist:
                pass
            # Clear coupon from session
            request.session.pop('coupon_code', None)
            request.session.pop('coupon_discount', None)

    if mypayment_method == ' Cash On Delivery':
        return redirect('/thankyou/')
    else:
        return redirect('/payment_process/')
	
def thankyou(request):
    return render(request,'thank-you-page.html')

def related(request):
    product = Product.objects.filter(status='PUBLISH')[:4]
    context ={
        'product': product,
    }
    return render(request,'related.html',context)

def PRODUCT(request):
    categories = Categories.objects.all()
    filter_price = Filter_Price.objects.all()
    
    CATID = request.GET.get('categories')
    SubCATID = request.GET.get('subcategories')
    Filter_Price_id = request.GET.get('filter_price')
    rating = request.GET.get('rating')
    sort_by = request.GET.get('sort')
    discount_filter = request.GET.get('discount')
    stock_filter = request.GET.get('stock')

    # Base queryset with annotations
    product = Product.objects.filter(status='PUBLISH').annotate(
        avg_rating=Avg('review__rating'),
        review_count=Count('review')
    )

    if CATID:
        product = product.filter(categories=CATID)
    
    if SubCATID:
        product = product.filter(subcategories=SubCATID)
    
    if Filter_Price_id:
        product = product.filter(filter_price=Filter_Price_id)

    if discount_filter:
        try:
            d_val = int(discount_filter)
            product = product.filter(discount_percentage__gte=d_val)
        except ValueError:
            pass
    
    if stock_filter:
        if stock_filter == 'in':
            product = product.filter(stock__gt=0)
        elif stock_filter == 'out':
            product = product.filter(stock__lte=0)

    if rating:
        try:
            rating_val = int(rating)
            product = product.filter(avg_rating__gte=rating_val)
        except ValueError:
            pass

    if sort_by:
        if sort_by == 'price_asc':
            product = product.order_by('price')
        elif sort_by == 'price_desc':
            product = product.order_by('-price')
        elif sort_by == 'newest':
            product = product.order_by('-created_date')
        elif sort_by == 'best_selling':
            # Since we don't have a direct link to Orderitem, approximate with review count
            product = product.order_by('-review_count')
    else:
        product = product.order_by('-id')

    from django.core.paginator import Paginator
    paginator = Paginator(product, 6) # Show 6 products per page so multiple pages are visible
    page_number = request.GET.get('page')
    product_obj = paginator.get_page(page_number)

    context ={
         'product': product_obj,
         'categories': categories,
         'filter_price': filter_price,
         'selected_rating': rating,
         'sort_by': sort_by,
     }

    return render(request,'shop-left-sidebar.html',context)

def DetailsPage(request,id):
    prod = Product.objects.filter(id=id).first()
    
    # ── Track User Activity For Recommendations ──
    if prod:
        if not request.session.session_key:
            request.session.create()
        session_key = request.session.session_key
        
        if request.user.is_authenticated:
            UserActivity.objects.create(user=request.user, session_key=session_key, product=prod)
        else:
            UserActivity.objects.create(session_key=session_key, product=prod)
            
    related = Product.objects.filter(categories=prod.categories).exclude(id=id)[:4]
    reviews = Review.objects.filter(product=prod).select_related('user').order_by('-created_at')
    avg_rating = reviews.aggregate(avg=Avg('rating'))['avg'] or 0
    avg_rating_int = int(round(avg_rating)) if avg_rating else 0
    in_wishlist = False
    if request.user.is_authenticated:
        in_wishlist = Wishlist.objects.filter(user=request.user, product=prod).exists()
    context = {
        'prod': prod,
        'related': related,
        'reviews': reviews,
        'avg_rating': avg_rating,
        'avg_rating_int': avg_rating_int,
        'reviews_count': reviews.count(),
        'in_wishlist': in_wishlist,
    }
    return render(request, 'single-product.html', context)

def regstore(request):
    # auth_user
    myfname = request.POST['fname']
    mylname = request.POST['lname']
    myemail = request.POST['email']
    myusername = request.POST['username']
    mypassword = request.POST['password']
    mycpassword = request.POST['cpassword']
    mygender = request.POST['gender']  # Assuming you're using gender in the form
    mycontact = request.POST['contact']
    myaddress = request.POST['address']

    if mypassword == mycpassword:
        result = User.objects.create_user(first_name=myfname, last_name=mylname, email=myemail, username=myusername, password=mypassword)
        Profile.objects.create(gender=mygender,contact=mycontact, address=myaddress, user_id=result.id)
        return redirect('/Login/')
    else:
        messages.success(request, "Mismatch Password")
        return redirect('/registration/')


def send_otp(user):
    otp = f"{random.randint(100000, 999999)}"
    EmailOTP.objects.filter(user=user).delete()
    EmailOTP.objects.create(user=user, otp=otp)

    subject = "Your One-Time Password (OTP) for Login"
    message = f"""
Dear {user.first_name or user.username},

Your One-Time Password (OTP) for logging into your Appliances Heaven account is:

    {otp}

This OTP is valid for the next 5 minutes.
Please do not share this code with anyone.

If you did not try to log in, you can safely ignore this email.

Best regards,
Appliances Heaven Team
"""
    from_email = settings.EMAIL_HOST_USER
    recipient_list = [user.email]
    send_mail(subject, message, from_email, recipient_list, fail_silently=False)


def login_check(request):
    myusername = request.POST.get('username')
    mypassword = request.POST.get('password')

    result = auth.authenticate(username=myusername, password=mypassword)
    if result is None:
        messages.success(request, "Invalid Username or Password")
        return redirect('/Login/')
    else:
        if result.is_superuser:
            messages.success(request, "Invalid Username or Password")
            return redirect('/Login/')
        else:
            request.session['user_id'] = result.id
            send_otp(result)
            return redirect('verify_otp')


def verify_otp(request):

    if request.method == "POST":

        otp = request.POST['otp']
        user_id = request.session.get('user_id')

        user = User.objects.get(id=user_id)
        otp_obj = EmailOTP.objects.get(user=user)

        if timezone.now() - otp_obj.created_at > timedelta(minutes=5):
            return render(request, 'verify_otp.html', {'error': 'OTP expired'})

        if otp_obj.otp == otp:
            auth.login(request, user)
            return redirect('HomePage')

        else:
            return render(request, 'verify_otp.html', {'error': 'Invalid OTP'})

    return render(request, 'verify_otp.html')


def resend_otp(request):

    user_id = request.session.get('user_id')
    user = User.objects.get(id=user_id)

    send_otp(user)

    return redirect('verify_otp')


@login_required(login_url="/Login/")
def add_review(request, product_id):
    if request.method == "POST":
        rating = request.POST.get('rating')
        comment = request.POST.get('comment', '').strip()
        image = request.FILES.get('image')

        if rating and comment:
            Review.objects.create(
                user=request.user,
                product_id=product_id,
                rating=int(rating),
                comment=comment,
                image=image,
            )

    return redirect('DetailsPage', id=product_id)
def logout(request):
    auth.logout(request)
    return redirect('/Login/')

def profile(request):
    user_id = request.user.id
    profile = Profile.objects.get(user_id=user_id)
    context = {'profile':profile}
    return render(request,'profile.html',context)

def profile_edit(request,id):
    user_id = request.user.id
    profile = Profile.objects.get(user_id=user_id)
    context = {'profile':profile}
    return render(request,'profile_edit.html',context)

def profile_update(request,id):
    # auth_user
    myfname = request.POST['fname']
    mylname = request.POST['lname']
    myemail = request.POST['email']
    myusername = request.POST['username']
    mygender = request.POST['gender']  # Assuming you're using gender in the form
    mycontact = request.POST['contact']
    myaddress = request.POST['address']

    data={
        'first_name':myfname,
        'last_name':mylname,
        'email':myemail,
        'username':myusername,
        'gender':mygender,
        'contact':mycontact,
        'address':myaddress
    }
    
    User.objects.update_or_create(pk=id,defaults=data)
    Profile.objects.update_or_create(user_id=id,defaults=data)

    return redirect('/profile')

def profile_address(request):
    user_id = request.user.id
    profile = Profile.objects.get(user_id=user_id)
    context = {'profile':profile}
    return render(request,'profile_address.html',context)

def orderhistory(request):
    userid=request.user.id
    order=Order.objects.filter(user_id=userid)
    if not order:
        messages.success(request, "You have no orders yet.")
        return render(request,'orderhistory.html')
    else:
        message = ''
        context = {'order':order}
        return render(request,'orderhistory.html',context)

def orderview(request,id):
    orderitem  =Orderitem.objects.filter(order_id=id)
    order =Order.objects.get(id=id)
	
    context = {'orderitem':orderitem,
                'order':order,
    }
    return render(request,'orderview.html',context)

def payment_process(request):
    key_id = 'rzp_test_PvM4GxK9MYlCUc'
    key_secret = 'WzsOTRAU4l3oAA1CS7jlVS5E'

    obj= Order.objects.filter(user_id=request.user.id).order_by('-id')[0]
    if obj.amount:
        # For Razorpay (paise)
        razor_amount = int(float(obj.amount) * 100)     
        # For display (rupees)
        display_amount = obj.amount
    

    client = razorpay.Client(auth=(key_id, key_secret))

    data = {
        'amount': razor_amount,
        'currency': 'INR',
        "receipt":"OIBP",
        "notes":{
            'name' : 'AK',
            'payment_for':'OIBP Test'
        }
    }
    id = request.user.id
    result = User.objects.get(pk=id)
    payment = client.order.create(data=data)
    
    # Store the razorpay_order_id in our Order model to track it correctly
    obj.payment_id = payment['id']
    obj.save()

    context = {
        'payment' : payment,
        'result': result,
        'display_amount': display_amount,
        'order': obj
    }
    return render(request, 'payment_process.html',context)

@csrf_exempt
def success(request):
    # Retrieve identifiers from Razorpay callback
    razorpay_order_id = request.POST.get('razorpay_order_id')
    razorpay_payment_id = request.POST.get('razorpay_payment_id')
    razorpay_signature = request.POST.get('razorpay_signature')
    
    print(f"DEBUG: Processing success for Razorpay Order ID: {razorpay_order_id}")
    
    try:
        if razorpay_order_id:
            # Match the order exactly via the ID we generated earlier in Razorpay.Client
            order_to_update = Order.objects.filter(payment_id=razorpay_order_id).first()
            
            if order_to_update:
                order_to_update.paid = True
                # Store the actual successful transaction ID from Razorpay
                if razorpay_payment_id:
                    order_to_update.payment_id = razorpay_payment_id
                
                order_to_update.save()
                print(f"DEBUG: Successfully marked Order #{order_to_update.id} as PAID.")
            else:
                print(f"DEBUG: Order with payment_id {razorpay_order_id} NOT found in database.")
                # Manual fallback if lookup by razorpay_order_id failed
                if request.user.is_authenticated:
                    latest_order = Order.objects.filter(user=request.user).latest('id')
                    latest_order.paid = True
                    latest_order.save()
        else:
            print("DEBUG: No razorpay_order_id received in POST data.")
            if request.user.is_authenticated:
                latest_order = Order.objects.filter(user=request.user).latest('id')
                latest_order.paid = True
                latest_order.save()
                
    except Exception as e:
        print(f"CRITICAL ERROR in payment success: {str(e)}")
        
    return render(request, 'payment_success.html')

def search(request):
    query=request.GET.get('query')
    product = Product.objects.filter(name__icontains = query)
    context = {
        'product': product
    }
    return render(request,'search.html',context)

def update_password(request):
    if request.method == "POST":
        old_password = request.POST['pwd1']
        new_password = request.POST['pwd2']
        confirm_password = request.POST['pwd3']

        user = User.objects.get(username=request.user.username)

        # Check if the old password matches the current password
        if not user.check_password(old_password):
            messages.error(request, 'Old password is incorrect.')
            return redirect("/update_password/")

        # Check if the new password and confirmation match
        if new_password != confirm_password:
            messages.error(request, 'New password and confirmation do not match.')
            return redirect("/update_password/")

        # Set and save the new password
        user.set_password(new_password)
        user.save()

        messages.success(request, 'Password changed successfully.')
        return redirect("/Login/")

    return render(request, 'changepassword.html')
   


@login_required(login_url="/Login/")
def cart_add(request, id):
    cart = Cart(request)
    product = Product.objects.get(id=id)
    cart.add(product=product)
    return redirect("/")

@login_required(login_url="/Login/")
def item_clear(request, id):
    cart = Cart(request)
    product = Product.objects.get(id=id)
    cart.remove(product)
    return redirect("cart_detail")


@login_required(login_url="/Login/")
def item_increment(request, id):
    cart = Cart(request)
    product = Product.objects.get(id=id)
    cart.add(product=product)
    return redirect("cart_detail")


@login_required(login_url="/Login/")
def item_decrement(request, id):
    cart = Cart(request)
    product = Product.objects.get(id=id)
    cart.decrement(product=product)
    return redirect("cart_detail")


@login_required(login_url="/Login/")
def cart_clear(request):
    cart = Cart(request)
    cart.clear()
    return redirect("cart_detail")


@login_required(login_url="/Login/")
def cart_detail(request):
    # Build enriched cart data with discounted prices
    cart_session = request.session.get('cart', {})
    enriched_cart = []
    cart_subtotal = Decimal('0')

    for key, value in cart_session.items():
        try:
            product = Product.objects.get(id=value['product_id'])
            unit_price = Decimal(str(product.get_discounted_price()))
            original_price = product.price
            discount_pct = product.discount_percentage if product.is_offer_active() else 0
        except Exception:
            unit_price = Decimal(str(value.get('price', 0)))
            original_price = unit_price
            discount_pct = 0

        qty = int(value.get('quantity', 1))
        subtotal = unit_price * qty
        cart_subtotal += subtotal
        enriched_cart.append({
            'key': key,
            'product_id': value.get('product_id'),
            'name': value.get('name'),
            'image': value.get('image'),
            'original_price': original_price,
            'unit_price': unit_price,
            'discount_pct': discount_pct,
            'quantity': qty,
            'subtotal': subtotal,
        })

    coupon_discount = Decimal(str(request.session.get('coupon_discount', '0')))
    coupon_code = request.session.get('coupon_code', '')
    
    amount_after_coupon = cart_subtotal - coupon_discount
    gst_amount = amount_after_coupon * Decimal('0.18')
    delivery_charge = Decimal('80.00') if amount_after_coupon > 0 else Decimal('0.00')
    final_total = amount_after_coupon + gst_amount + delivery_charge

    context = {
        'enriched_cart': enriched_cart,
        'cart_subtotal': cart_subtotal,
        'coupon_discount': coupon_discount,
        'coupon_code': coupon_code,
        'gst_amount': gst_amount,
        'delivery_charge': delivery_charge,
        'final_total': final_total,
    }
    return render(request, 'cart_details.html', context)


@login_required(login_url="/Login/")
def apply_coupon(request):
    """Validate and apply coupon, store result in session."""
    if request.method == 'POST':
        code = request.POST.get('coupon_code', '').strip().upper()

        # Guard: empty code
        if not code:
            messages.error(request, 'Please enter a coupon code.')
            return redirect('cart_detail')

        # Compute current cart subtotal with discounted prices
        cart_session = request.session.get('cart', {})
        cart_subtotal = Decimal('0')
        for key, value in cart_session.items():
            try:
                pid = value.get('product_id') or key
                product = Product.objects.get(id=pid)
                unit_price = Decimal(str(product.get_discounted_price()))
            except Exception:
                unit_price = Decimal(str(value.get('price', 0)))
            cart_subtotal += unit_price * int(value.get('quantity', 1))

        # Case-insensitive lookup
        try:
            coupon = Coupon.objects.get(code__iexact=code)
        except Coupon.DoesNotExist:
            messages.error(request, f'Invalid coupon code "{code}". Please check and try again.')
            return redirect('cart_detail')

        is_valid, error = coupon.is_valid(cart_total=cart_subtotal)
        if is_valid:
            discount = coupon.apply(cart_subtotal)
            request.session['coupon_code'] = coupon.code
            request.session['coupon_discount'] = str(discount)
            request.session.modified = True
            messages.success(request, f'Coupon "{coupon.code}" applied successfully! You saved ₹{discount}.')
        else:
            messages.error(request, error)

    return redirect('cart_detail')


@login_required(login_url="/Login/")
def remove_coupon(request):
    """Remove coupon from session."""
    request.session.pop('coupon_code', None)
    request.session.pop('coupon_discount', None)
    messages.success(request, 'Coupon removed.')
    return redirect('cart_detail')


@login_required(login_url="/Login/")
def wishlist_add(request, product_id):
    product = Product.objects.get(id=product_id)
    Wishlist.objects.get_or_create(user=request.user, product=product)
    return redirect('DetailsPage', id=product_id)


@login_required(login_url="/Login/")
def wishlist_list(request):
    items = Wishlist.objects.filter(user=request.user).select_related('product').order_by('-created_at')
    context = {'items': items}
    return render(request, 'wishlist.html', context)

@login_required(login_url="/Login/")
def wishlist_remove(request, product_id):
    try:
        wishlist_item = Wishlist.objects.get(user=request.user, product__id=product_id)
        wishlist_item.delete()
        messages.success(request, 'Item removed from your wishlist.')
    except Wishlist.DoesNotExist:
        pass
    
    return redirect(request.META.get('HTTP_REFERER', '/'))
@login_required(login_url="/Login/")
def track_order(request):
    status_filter = request.GET.get('status', 'all')
    orders = Order.objects.filter(user=request.user)
    
    if status_filter != 'all':
        orders = orders.filter(status=status_filter)
        
    return render(request, 'track_order.html', {'orders': orders, 'current_filter': status_filter})

@login_required(login_url="/Login/")
def order_cancel(request, order_id):
    if request.method == 'POST':
        try:
            order = Order.objects.get(id=order_id, user=request.user)
            # Only allow cancelling orders that are pending or confirmed
            if order.status in ['pending', 'confirmed'] and not order.is_cancelled:
                order.is_cancelled = True
                order.status = 'cancelled'
                order.save()
                messages.success(request, f'Order #{order.id} has been cancelled successfully.')
            else:
                messages.error(request, 'This order cannot be cancelled.')
        except Order.DoesNotExist:
            messages.error(request, 'Order not found.')
            
    return redirect('track_order')
