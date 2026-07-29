from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.models import User
from django.contrib import messages
from django.http import JsonResponse
from django.db.models import Sum, Count, Q
from django.utils import timezone
from datetime import timedelta, date
from decimal import Decimal
import json
import csv
import io

from store.models import (
    Product, Categories, SubCategories, Filter_Price,
    Order, Orderitem, Profile, Coupon, Review, Wishlist,
    contact_us, images
)


def admin_required(view_func):
    """Decorator: only allow superusers into admin panel."""
    decorated = login_required(login_url='/admin-panel/login/')(
        user_passes_test(lambda u: u.is_superuser, login_url='/admin-panel/login/')(view_func)
    )
    return decorated


# ────────────────────────────── AUTH ────────────────────────────────────────

def admin_login(request):
    if request.user.is_authenticated and request.user.is_superuser:
        return redirect('admin_dashboard')
    if request.method == 'POST':
        from django.contrib import auth as django_auth
        username = request.POST.get('username', '').strip()
        password = request.POST.get('password', '').strip()
        user = django_auth.authenticate(request, username=username, password=password)
        if user and user.is_superuser:
            django_auth.login(request, user)
            return redirect('admin_dashboard')
        else:
            messages.error(request, 'Invalid credentials or not an admin account.')
    return render(request, 'custom_admin/login.html')


def admin_logout(request):
    from django.contrib import auth as django_auth
    django_auth.logout(request)
    return redirect('admin_login')


# ────────────────────────────── DASHBOARD ───────────────────────────────────

@admin_required
def admin_dashboard(request):
    total_products = Product.objects.count()
    total_orders   = Order.objects.count()
    total_users    = User.objects.filter(is_superuser=False).count()

    # Revenue from paid orders
    paid_orders = Order.objects.filter(paid=True)
    total_revenue = sum(Decimal(str(o.amount)) for o in paid_orders if o.amount)

    # Pending orders
    pending_orders = Order.objects.filter(status='pending').count()

    # Last 7 days orders per day
    today = date.today()
    order_labels = []
    order_data   = []
    revenue_data = []
    for i in range(6, -1, -1):
        day = today - timedelta(days=i)
        count = Order.objects.filter(orderdate=day).count()
        rev   = sum(
            Decimal(str(o.amount)) for o in Order.objects.filter(orderdate=day, paid=True) if o.amount
        )
        order_labels.append(day.strftime('%d %b'))
        order_data.append(count)
        revenue_data.append(float(rev))

    # Top 5 recent orders
    recent_orders = Order.objects.order_by('-id')[:5]

    # Low stock products (qty not in model, so show latest 5 products)
    latest_products = Product.objects.order_by('-id')[:5]

    # Orders by status
    status_counts = {
        'pending':         Order.objects.filter(status='pending').count(),
        'confirmed':       Order.objects.filter(status='confirmed').count(),
        'shipped':         Order.objects.filter(status='shipped').count(),
        'out_for_delivery':Order.objects.filter(status='out_for_delivery').count(),
        'delivered':       Order.objects.filter(status='delivered').count(),
    }

    context = {
        'total_products': total_products,
        'total_orders':   total_orders,
        'total_users':    total_users,
        'total_revenue':  total_revenue,
        'pending_orders': pending_orders,
        'order_labels':   json.dumps(order_labels),
        'order_data':     json.dumps(order_data),
        'revenue_data':   json.dumps(revenue_data),
        'recent_orders':  recent_orders,
        'latest_products':latest_products,
        'status_counts':  status_counts,
        'active_page':    'dashboard',
    }
    return render(request, 'custom_admin/dashboard.html', context)


# ────────────────────────────── PRODUCTS ────────────────────────────────────

@admin_required
def admin_products(request):
    query = request.GET.get('q', '')
    category_filter = request.GET.get('category', '')

    products = Product.objects.select_related('categories', 'subcategories').order_by('-id')
    if query:
        products = products.filter(name__icontains=query)
    if category_filter:
        products = products.filter(categories_id=category_filter)

    categories = Categories.objects.all()
    context = {
        'products': products,
        'categories': categories,
        'query': query,
        'category_filter': category_filter,
        'active_page': 'products',
    }
    return render(request, 'custom_admin/products.html', context)


@admin_required
def admin_product_add(request):
    categories    = Categories.objects.all()
    subcategories = SubCategories.objects.all()
    filter_prices = Filter_Price.objects.all()

    if request.method == 'POST':
        name           = request.POST.get('name', '').strip()
        price          = request.POST.get('price')
        description    = request.POST.get('description', '').strip()
        status         = request.POST.get('status', 'PUBLISH')
        cat_id         = request.POST.get('categories')
        subcat_id      = request.POST.get('subcategories')
        fp_id          = request.POST.get('filter_price')
        discount_pct   = request.POST.get('discount_percentage', 0)
        stock          = request.POST.get('stock', 0)
        is_deal        = request.POST.get('is_deal_of_day') == 'on'
        offer_expiry   = request.POST.get('offer_expiry') or None
        image          = request.FILES.get('image')

        product = Product.objects.create(
            name=name,
            price=price,
            description=description,
            status=status,
            categories_id=cat_id,
            subcategories_id=subcat_id,
            filter_price_id=fp_id,
            discount_percentage=discount_pct,
            is_deal_of_day=is_deal,
            offer_expiry=offer_expiry,
            stock=stock,
            image=image,
        )

        # Handle multiple additional images
        extra_images = request.FILES.getlist('extra_images')
        for img_file in extra_images:
            images.objects.create(product=product, image=img_file)

        messages.success(request, f'Product "{product.name}" added successfully!')
        return redirect('admin_products')

    context = {
        'categories':    categories,
        'subcategories': subcategories,
        'filter_prices': filter_prices,
        'active_page':   'products',
    }
    return render(request, 'custom_admin/product_form.html', context)


@admin_required
def admin_product_edit(request, pk):
    product       = get_object_or_404(Product, pk=pk)
    categories    = Categories.objects.all()
    subcategories = SubCategories.objects.all()
    filter_prices = Filter_Price.objects.all()

    if request.method == 'POST':
        product.name                = request.POST.get('name', product.name).strip()
        product.price               = request.POST.get('price', product.price)
        product.description         = request.POST.get('description', product.description).strip()
        product.status              = request.POST.get('status', product.status)
        product.categories_id       = request.POST.get('categories', product.categories_id)
        product.subcategories_id    = request.POST.get('subcategories', product.subcategories_id)
        product.filter_price_id     = request.POST.get('filter_price', product.filter_price_id)
        product.discount_percentage = request.POST.get('discount_percentage', product.discount_percentage)
        product.is_deal_of_day      = request.POST.get('is_deal_of_day') == 'on'
        product.offer_expiry        = request.POST.get('offer_expiry') or None
        product.stock               = request.POST.get('stock', product.stock)
        if request.FILES.get('image'):
            product.image = request.FILES['image']
        product.save()

        # Handle multiple additional images
        extra_images = request.FILES.getlist('extra_images')
        for img_file in extra_images:
            images.objects.create(product=product, image=img_file)

        messages.success(request, f'Product "{product.name}" updated!')
        return redirect('admin_products')

    context = {
        'product':       product,
        'categories':    categories,
        'subcategories': subcategories,
        'filter_prices': filter_prices,
        'active_page':   'products',
        'is_edit':       True,
    }
    return render(request, 'custom_admin/product_form.html', context)


@admin_required
def admin_product_delete(request, pk):
    if request.method == 'POST':
        product = get_object_or_404(Product, pk=pk)
        name = product.name
        product.delete()
        messages.success(request, f'Product "{name}" deleted.')
    return redirect('admin_products')


# ────────────────────────────── CATEGORIES ──────────────────────────────────

@admin_required
def admin_categories(request):
    categories    = Categories.objects.all()
    subcategories = SubCategories.objects.all()
    context = {
        'categories':    categories,
        'subcategories': subcategories,
        'active_page':   'categories',
    }
    return render(request, 'custom_admin/categories.html', context)


@admin_required
def admin_category_add(request):
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        if name:
            Categories.objects.create(name=name)
            messages.success(request, f'Category "{name}" added!')
    return redirect('admin_categories')


@admin_required
def admin_category_edit(request, pk):
    cat = get_object_or_404(Categories, pk=pk)
    if request.method == 'POST':
        cat.name = request.POST.get('name', cat.name).strip()
        cat.save()
        messages.success(request, 'Category updated!')
    return redirect('admin_categories')


@admin_required
def admin_category_delete(request, pk):
    if request.method == 'POST':
        cat = get_object_or_404(Categories, pk=pk)
        cat.delete()
        messages.success(request, 'Category deleted.')
    return redirect('admin_categories')


@admin_required
def admin_subcategory_add(request):
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        if name:
            SubCategories.objects.create(name=name)
            messages.success(request, f'Subcategory "{name}" added!')
    return redirect('admin_categories')


@admin_required
def admin_subcategory_edit(request, pk):
    sub = get_object_or_404(SubCategories, pk=pk)
    if request.method == 'POST':
        sub.name = request.POST.get('name', sub.name).strip()
        sub.save()
        messages.success(request, 'Subcategory updated!')
    return redirect('admin_categories')


@admin_required
def admin_subcategory_delete(request, pk):
    if request.method == 'POST':
        sub = get_object_or_404(SubCategories, pk=pk)
        sub.delete()
        messages.success(request, 'Subcategory deleted.')
    return redirect('admin_categories')


# ────────────────────────────── ORDERS ──────────────────────────────────────

@admin_required
def admin_orders(request):
    status_filter = request.GET.get('status', '')
    query         = request.GET.get('q', '')

    orders = Order.objects.order_by('-id')
    if status_filter:
        orders = orders.filter(status=status_filter)
    if query:
        orders = orders.filter(
            Q(firstname__icontains=query) |
            Q(lastname__icontains=query)  |
            Q(email__icontains=query)     |
            Q(id__icontains=query)
        )

    context = {
        'orders':        orders,
        'status_filter': status_filter,
        'query':         query,
        'active_page':   'orders',
        'STATUS_CHOICES': Order.STATUS_CHOICES,
    }
    return render(request, 'custom_admin/orders.html', context)


@admin_required
def admin_order_detail(request, pk):
    order      = get_object_or_404(Order, pk=pk)
    order_items = Orderitem.objects.filter(order=order)

    if request.method == 'POST':
        new_status = request.POST.get('status')
        delivery_date_str = request.POST.get('delivery_date')
        
        if new_status:
            order.status = new_status
        
        if delivery_date_str:
            from datetime import datetime
            try:
                # Convert string from input type="date" (YYYY-MM-DD) to a date object
                order.delivery_date = datetime.strptime(delivery_date_str, '%Y-%m-%d').date()
            except ValueError:
                # Fallback if format is weird, though browser date pickers are consistent
                pass
        
        order.save()
        messages.success(request, f'Order #{order.id} status updated to {order.get_status_display()}.')
        return redirect('admin_order_detail', pk=pk)

    context = {
        'order':       order,
        'order_items': order_items,
        'active_page': 'orders',
        'STATUS_CHOICES': Order.STATUS_CHOICES,
    }
    return render(request, 'custom_admin/order_detail.html', context)


# ────────────────────────────── USERS ───────────────────────────────────────

@admin_required
def admin_users(request):
    query = request.GET.get('q', '')
    users = User.objects.filter(is_superuser=False).order_by('-date_joined')
    if query:
        users = users.filter(
            Q(username__icontains=query) |
            Q(email__icontains=query)    |
            Q(first_name__icontains=query)
        )
    context = {
        'users':       users,
        'query':       query,
        'active_page': 'users',
    }
    return render(request, 'custom_admin/users.html', context)


@admin_required
def admin_user_toggle(request, pk):
    """Block / Unblock a user."""
    if request.method == 'POST':
        user = get_object_or_404(User, pk=pk)
        user.is_active = not user.is_active
        user.save()
        status_word = 'unblocked' if user.is_active else 'blocked'
        messages.success(request, f'User "{user.username}" has been {status_word}.')
    return redirect('admin_users')


@admin_required
def admin_user_detail(request, pk):
    user   = get_object_or_404(User, pk=pk)
    orders = Order.objects.filter(user=user).order_by('-id')
    try:
        profile = Profile.objects.get(user=user)
    except Profile.DoesNotExist:
        profile = None
    context = {
        'viewed_user': user,
        'orders':      orders,
        'profile':     profile,
        'active_page': 'users',
    }
    return render(request, 'custom_admin/user_detail.html', context)


# ────────────────────────────── COUPONS ─────────────────────────────────────

@admin_required
def admin_coupons(request):
    coupons = Coupon.objects.all().order_by('-created_at')
    context = {'coupons': coupons, 'active_page': 'coupons'}
    return render(request, 'custom_admin/coupons.html', context)


@admin_required
def admin_coupon_add(request):
    if request.method == 'POST':
        code           = request.POST.get('code', '').strip().upper()
        disc           = request.POST.get('discount_percentage')
        min_order      = request.POST.get('min_order_amount', 0)
        max_uses       = request.POST.get('max_uses', 0)
        is_active      = request.POST.get('is_active') == 'on'
        valid_from     = request.POST.get('valid_from') or timezone.now()
        valid_to       = request.POST.get('valid_to') or None
        Coupon.objects.create(
            code=code, discount_percentage=disc,
            min_order_amount=min_order, max_uses=max_uses,
            is_active=is_active, valid_from=valid_from, valid_to=valid_to
        )
        messages.success(request, f'Coupon "{code}" created!')
        return redirect('admin_coupons')
    return render(request, 'custom_admin/coupon_form.html', {'active_page': 'coupons'})


@admin_required
def admin_coupon_edit(request, pk):
    coupon = get_object_or_404(Coupon, pk=pk)
    if request.method == 'POST':
        coupon.code                = request.POST.get('code', coupon.code).strip().upper()
        coupon.discount_percentage = request.POST.get('discount_percentage', coupon.discount_percentage)
        coupon.min_order_amount    = request.POST.get('min_order_amount', coupon.min_order_amount)
        coupon.max_uses            = request.POST.get('max_uses', coupon.max_uses)
        coupon.is_active           = request.POST.get('is_active') == 'on'
        coupon.valid_from          = request.POST.get('valid_from') or coupon.valid_from
        coupon.valid_to            = request.POST.get('valid_to') or None
        coupon.save()
        messages.success(request, 'Coupon updated!')
        return redirect('admin_coupons')
    return render(request, 'custom_admin/coupon_form.html', {'coupon': coupon, 'is_edit': True, 'active_page': 'coupons'})


@admin_required
def admin_coupon_delete(request, pk):
    if request.method == 'POST':
        coupon = get_object_or_404(Coupon, pk=pk)
        coupon.delete()
        messages.success(request, 'Coupon deleted.')
    return redirect('admin_coupons')


# ────────────────────────────── REPORTS ─────────────────────────────────────

@admin_required
def admin_reports(request):
    from_date = request.GET.get('from_date', '')
    to_date   = request.GET.get('to_date', '')

    orders = Order.objects.all()
    if from_date:
        orders = orders.filter(orderdate__gte=from_date)
    if to_date:
        orders = orders.filter(orderdate__lte=to_date)

    total_orders   = orders.count()
    delivered      = orders.filter(status='delivered').count()
    cancelled      = orders.filter(status__in=['cancelled']).count()
    total_revenue  = sum(Decimal(str(o.amount)) for o in orders.filter(paid=True) if o.amount)
    cod_orders     = orders.filter(payment_method__icontains='Cash').count()
    online_orders  = orders.exclude(payment_method__icontains='Cash').count()

    # Category-wise product count
    category_labels = list(Categories.objects.values_list('name', flat=True))
    category_counts = [Product.objects.filter(categories__name=c).count() for c in category_labels]

    # Monthly revenue (last 6 months)
    today = date.today()
    monthly_labels = []
    monthly_revenue = []
    for i in range(5, -1, -1):
        month_start = (today.replace(day=1) - timedelta(days=i * 30))
        month_start = month_start.replace(day=1)
        month_end   = (month_start.replace(month=month_start.month % 12 + 1, day=1) - timedelta(days=1))
        rev = sum(
            Decimal(str(o.amount))
            for o in Order.objects.filter(paid=True, orderdate__gte=month_start, orderdate__lte=month_end)
            if o.amount
        )
        monthly_labels.append(month_start.strftime('%b %Y'))
        monthly_revenue.append(float(rev))

    context = {
        'orders':          orders,
        'total_orders':    total_orders,
        'delivered':       delivered,
        'cancelled':       cancelled,
        'total_revenue':   total_revenue,
        'cod_orders':      cod_orders,
        'online_orders':   online_orders,
        'from_date':       from_date,
        'to_date':         to_date,
        'category_labels': json.dumps(category_labels),
        'category_counts': json.dumps(category_counts),
        'monthly_labels':  json.dumps(monthly_labels),
        'monthly_revenue': json.dumps(monthly_revenue),
        'active_page':     'reports',
    }
    return render(request, 'custom_admin/reports.html', context)


# ────────────────────────────── REVIEWS ─────────────────────────────────────

@admin_required
def admin_reviews(request):
    query      = request.GET.get('q', '')
    rating_f   = request.GET.get('rating', '')
    reviews    = Review.objects.select_related('user', 'product').order_by('-created_at')

    if query:
        reviews = reviews.filter(
            Q(user__username__icontains=query) |
            Q(product__name__icontains=query)  |
            Q(comment__icontains=query)
        )
    if rating_f:
        reviews = reviews.filter(rating=rating_f)

    context = {
        'reviews':     reviews,
        'query':       query,
        'rating_f':    rating_f,
        'active_page': 'reviews',
    }
    return render(request, 'custom_admin/reviews.html', context)


@admin_required
def admin_review_delete(request, pk):
    if request.method == 'POST':
        review = get_object_or_404(Review, pk=pk)
        review.delete()
        messages.success(request, 'Review deleted.')
    return redirect('admin_reviews')


# ────────────────────────────── WISHLISTS ───────────────────────────────────

@admin_required
def admin_wishlists(request):
    query     = request.GET.get('q', '')
    wishlists = Wishlist.objects.select_related('user', 'product').order_by('-created_at')

    if query:
        wishlists = wishlists.filter(
            Q(user__username__icontains=query) |
            Q(product__name__icontains=query)
        )

    context = {
        'wishlists':   wishlists,
        'query':       query,
        'active_page': 'wishlists',
    }
    return render(request, 'custom_admin/wishlists.html', context)


@admin_required
def admin_wishlist_delete(request, pk):
    if request.method == 'POST':
        item = get_object_or_404(Wishlist, pk=pk)
        item.delete()
        messages.success(request, 'Wishlist item removed.')
    return redirect('admin_wishlists')


# ────────────────────────────── CONTACT US ──────────────────────────────────

@admin_required
def admin_contacts(request):
    query    = request.GET.get('q', '')
    contacts = contact_us.objects.all().order_by('-date')

    if query:
        contacts = contacts.filter(
            Q(name__icontains=query)    |
            Q(email__icontains=query)   |
            Q(subject__icontains=query)
        )

    context = {
        'contacts':    contacts,
        'query':       query,
        'active_page': 'contacts',
    }
    return render(request, 'custom_admin/contacts.html', context)


@admin_required
def admin_contact_detail(request, pk):
    contact = get_object_or_404(contact_us, pk=pk)
    context = {
        'contact':     contact,
        'active_page': 'contacts',
    }
    return render(request, 'custom_admin/contact_detail.html', context)


@admin_required
def admin_contact_delete(request, pk):
    if request.method == 'POST':
        c = get_object_or_404(contact_us, pk=pk)
        c.delete()
        messages.success(request, 'Contact message deleted.')
    return redirect('admin_contacts')


# ────────────────────────────── FILTER PRICE ────────────────────────────────

@admin_required
def admin_filter_prices(request):
    prices = Filter_Price.objects.all()
    context = {
        'prices':      prices,
        'active_page': 'filter_prices',
    }
    return render(request, 'custom_admin/filter_prices.html', context)


@admin_required
def admin_filter_price_add(request):
    if request.method == 'POST':
        price_val = request.POST.get('price', '').strip()
        if price_val:
            Filter_Price.objects.create(Price=price_val)
            messages.success(request, f'Price range "{price_val}" added!')
    return redirect('admin_filter_prices')


@admin_required
def admin_filter_price_edit(request, pk):
    fp = get_object_or_404(Filter_Price, pk=pk)
    if request.method == 'POST':
        fp.Price = request.POST.get('price', fp.Price).strip()
        fp.save()
        messages.success(request, 'Price range updated!')
    return redirect('admin_filter_prices')


@admin_required
def admin_filter_price_delete(request, pk):
    if request.method == 'POST':
        fp = get_object_or_404(Filter_Price, pk=pk)
        fp.delete()
        messages.success(request, 'Price range deleted.')
    return redirect('admin_filter_prices')


# ────────────────────────────── PRODUCT IMAGES ──────────────────────────────

@admin_required
def admin_product_images(request, product_pk):
    product  = get_object_or_404(Product, pk=product_pk)
    img_list = images.objects.filter(product=product)

    if request.method == 'POST':
        uploaded = request.FILES.getlist('images')
        for img_file in uploaded:
            images.objects.create(product=product, image=img_file)
        messages.success(request, f'{len(uploaded)} image(s) uploaded!')
        return redirect('admin_product_images', product_pk=product_pk)

    context = {
        'product':     product,
        'img_list':    img_list,
        'active_page': 'products',
    }
    return render(request, 'custom_admin/product_images.html', context)


@admin_required
def admin_product_image_delete(request, pk):
    if request.method == 'POST':
        img = get_object_or_404(images, pk=pk)
        product_pk = img.product_id
        img.delete()
        messages.success(request, 'Image deleted.')
        return redirect('admin_product_images', product_pk=product_pk)
    return redirect('admin_products')


@admin_required
def admin_product_bulk_upload(request):
    if request.method == 'POST':
        csv_file = request.FILES.get('csv_file')
        if not csv_file:
            messages.error(request, 'Please upload a CSV file.')
            return redirect('admin_product_bulk_upload')

        if not csv_file.name.endswith('.csv'):
            messages.error(request, 'Please upload a file with .csv extension.')
            return redirect('admin_product_bulk_upload')

        try:
            data_set = csv_file.read().decode('UTF-8')
            io_string = io.StringIO(data_set)
            next(io_string) # Skip header
            
            created_count = 0
            error_count = 0
            
            for column in csv.reader(io_string, delimiter=',', quotechar='"'):
                # Expected columns: name, price, description, category_name, subcategory_name, filter_price_range, discount_percentage, is_deal_of_day (on/off), status (PUBLISH/DRAFT)
                try:
                    name = column[0].strip()
                    price = column[1].strip()
                    description = column[2].strip()
                    category_name = column[3].strip()
                    subcategory_name = column[4].strip()
                    filter_price_range = column[5].strip()
                    discount_percentage = column[6].strip() or 0
                    is_deal = column[7].strip().lower() in ['on', 'true', '1', 'yes']
                    status = column[8].strip() or 'PUBLISH'
                    
                    category, _ = Categories.objects.get_or_create(name=category_name)
                    subcategory, _ = SubCategories.objects.get_or_create(name=subcategory_name)
                    filter_price, _ = Filter_Price.objects.get_or_create(Price=filter_price_range)
                    
                    Product.objects.create(
                        name=name,
                        price=price,
                        description=description,
                        categories=category,
                        subcategories=subcategory,
                        filter_price=filter_price,
                        discount_percentage=discount_percentage,
                        is_deal_of_day=is_deal,
                        status=status
                    )
                    created_count += 1
                except Exception as e:
                    error_count += 1
                    continue
            
            if created_count > 0:
                messages.success(request, f'Successfully added {created_count} products.')
            if error_count > 0:
                messages.warning(request, f'Failed to add {error_count} products. Please check your CSV format.')
                
            return redirect('admin_products')
            
        except Exception as e:
            messages.error(request, f'Error processing file: {str(e)}')
            return redirect('admin_product_bulk_upload')

    return render(request, 'custom_admin/product_bulk_upload.html', {'active_page': 'products'})
