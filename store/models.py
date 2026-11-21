from django.db import models
from django.utils import timezone
import datetime
from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.conf import settings

class Categories(models.Model):
    name = models.CharField(max_length=200)
    def __str__(self):
        return self.name

class SubCategories(models.Model):
    name = models.CharField(max_length=200)  # Add any additional fields you need
    # Add any other fields as per your requirements
    
    def __str__(self):
        return self.name
    
class Filter_Price(models.Model):
    FILTER_PRICE=(
        ('1000 to 10000','1000 to 10000'),
        ('10000 to 20000','10000 to 20000'),
        ('20000 to 30000','20000 to 30000'),
        ('30000 to 40000','30000 to 40000'),
        ('40000 to 50000','40000 to 50000'),
        ('More than 50000','More than 50000')
    )    
    Price = models.CharField(choices=FILTER_PRICE,max_length=60)
    def __str__(self):
        return self.Price     
    
class Product(models.Model):
    STATUS=(('PUBLISH','PUBLISH'),('DRAFT','DRAFT'))

    unique_id=models.CharField(unique=True, max_length=200,null=True,blank=True)
    name = models.CharField(max_length=100)
    image = models.ImageField(upload_to='news/',max_length=300,null=True,default=None)
    price = models.DecimalField(max_digits=8, decimal_places=2)
    description = models.TextField()
    status=models.CharField(choices=STATUS,max_length=200,default='PUBLISH')
    categories = models.ForeignKey(Categories, on_delete=models.CASCADE,default=2)
    subcategories = models.ForeignKey(SubCategories, on_delete=models.CASCADE,default=2)
    filter_price =models.ForeignKey(Filter_Price, on_delete=models.CASCADE,default=5)
    stock = models.IntegerField(default=0, help_text="Available items in stock")
    created_date = models.DateTimeField(default=timezone.now)

    # ── Offer / Discount Fields ──────────────────────────────────────────
    discount_percentage = models.DecimalField(
        max_digits=5, decimal_places=2, default=0,
        help_text="Discount percentage (0-100). e.g. 30 = 30% OFF"
    )
    is_deal_of_day = models.BooleanField(
        default=False,
        help_text="Mark this product as Deal of the Day"
    )
    offer_expiry = models.DateTimeField(
        null=True, blank=True,
        help_text="Offer expires at this datetime (leave blank = no expiry)"
    )
    # ─────────────────────────────────────────────────────────────────────

    def is_offer_active(self):
        """Returns True if a discount is set and the offer has not expired."""
        if self.discount_percentage and self.discount_percentage > 0:
            if self.offer_expiry:
                return timezone.now() < self.offer_expiry
            return True
        return False

    def get_discounted_price(self):
        """Returns the final selling price after applying discount."""
        if self.is_offer_active():
            discount = (self.price * self.discount_percentage) / 100
            return round(self.price - discount, 2)
        return self.price

    def get_savings(self):
        """Returns the amount saved (original - discounted)."""
        return round(self.price - self.get_discounted_price(), 2)

    def SAVE(self,*args,**kwargs):
        if not self.unique_id:
            self.unique_id = self.created_date.strftime('75%Y%m%d23') + str(self.id)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name
    
class images(models.Model):
    image=models.ImageField(upload_to='news/')        
    product=models.ForeignKey(Product, on_delete=models.CASCADE,default=1)


class Profile(models.Model):
    gender=models.CharField(max_length=15)
    contact = models.BigIntegerField()
    address = models.TextField()
    user = models.OneToOneField(User,on_delete=models.CASCADE)
    
    class Meta:
        db_table = 'profile'

class contact_us(models.Model):
    name=models.CharField(max_length=100)
    email=models.EmailField(max_length=100)
    subject=models.CharField(max_length=200)
    message=models.TextField()    
    date=models.DateTimeField(auto_now_add=True)

    

    def __str__(self):
        return self.email

class Order(models.Model):
    STATUS_CHOICES = [
        ('pending','Pending'),
        ('confirmed','Confirmed'),
        ('shipped','Shipped'),
        ('out_for_delivery','Out For Delivery'),
        ('delivered','Delivered'),
        ('cancelled','Cancelled'),
    ]

    user=models.ForeignKey(User,on_delete=models.CASCADE)
    firstname=models.CharField(max_length=100)
    lastname=models.CharField(max_length=100)
    state=models.CharField(max_length=100)
    address=models.TextField()
    city=models.CharField(max_length=100)
    firstname=models.CharField(max_length=100)
    pincode=models.IntegerField()
    phone=models.BigIntegerField()
    email=models.EmailField(max_length=100)
    amount=models.CharField(max_length=100,default='0')
    payment_id=models.CharField(max_length=300,null=True,blank=True)
    paid=models.BooleanField(default=False,null=True)
    orderdate=models.DateField(auto_now_add=True)
    payment_method = models.CharField(max_length=100,default='0')
    status = models.CharField(max_length=20,choices=STATUS_CHOICES,default='pending')
    delivery_date = models.DateField(null=True,blank=True)
    is_cancelled = models.BooleanField(default=False)
    cancel_reason = models.TextField(null=True, blank=True, help_text='Required when order is cancelled')

    def save(self, *args, **kwargs):
        is_new = self.pk is None
        old_status = None
        date_changed = False
        
        if not is_new:
            old_order = Order.objects.get(pk=self.pk)
            old_status = old_order.status
            date_changed = old_order.delivery_date != self.delivery_date

        # Keep cancelled flag in sync with status
        if self.status == 'cancelled':
            self.is_cancelled = True
        elif old_status == 'cancelled' and self.status != 'cancelled':
            self.is_cancelled = False
            self.cancel_reason = None
            
        super().save(*args, **kwargs)
        
        if is_new or old_status != self.status or date_changed:
            OrderStatusHistory.objects.create(order=self, status=self.status)
            
            # Send Email notification for specific statuses
            if self.status in ['confirmed', 'shipped', 'out_for_delivery', 'delivered', 'cancelled'] and self.email:
                status_display = self.get_status_display()
                subject = f"Update on Your Order #{self.id} - Appliances Heaven"
                
                message =  f"Dear {self.firstname} {self.lastname},\n\n"
                message += f"We are writing to inform you that the status of your order (#{self.id}) has been updated to: {status_display}.\n\n"
                
                if self.status == 'shipped' and self.delivery_date:
                    message += f"Great news! Your package is on its way. "
                    message += f"The estimated delivery date is {self.delivery_date.strftime('%B %d, %Y')}.\n\n"
                elif self.status == 'out_for_delivery':
                    message += "Exciting news! Your order is out for delivery and will be reaching you very soon. Please keep your phone reachable for our delivery partner!\n\n"
                elif self.status == 'delivered':
                    message += "Your package has been successfully delivered. We hope you enjoy your purchase!\n\n"
                elif self.status == 'confirmed':
                    message += "We are currently processing your order and will notify you once it has been shipped.\n\n"
                elif self.status == 'cancelled':
                    message += "We regret to inform you that your order has been cancelled.\n"
                    if self.cancel_reason:
                        message += f"Reason: {self.cancel_reason}\n\n"
                    else:
                        message += "\n"
                
                message += "You can track the live progress of your order by logging into your account and visiting the 'Track Order' / Order History section.\n\n"
                message += "If you have any questions or require further assistance, please do not hesitate to contact our support team.\n\n"
                message += "Warm regards,\n"
                message += "The Appliances Heaven Team"
                
                try:
                    send_mail(
                        subject,
                        message,
                        settings.EMAIL_HOST_USER,
                        [self.email],
                        fail_silently=True,
                    )
                except Exception as e:
                    pass

    def __str__(self):
        return self.user.username

class OrderStatusHistory(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='status_history')
    status = models.CharField(max_length=50)
    updated_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.order.id} - {self.status}"

class Orderitem(models.Model):
    order=models.ForeignKey(Order,on_delete=models.CASCADE)
    product=models.CharField(max_length=200)
    price=models.CharField(max_length=100)
    image=models.ImageField(upload_to='media/order_img')
    quantity=models.CharField(max_length=20)
    total=models.CharField(max_length=1000)

    def __str__(self):
        return self.order.user.username 


class EmailOTP(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    otp = models.CharField(max_length=6)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.otp}"


class Review(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    rating = models.IntegerField()
    comment = models.TextField()
    image = models.ImageField(upload_to='review_images/', null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} review"


class Wishlist(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'product')

    def __str__(self):
        return f"{self.user.username} - {self.product.name}"


# ── Recommendation System ──────────────────────────────────────────────────
class UserActivity(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    session_key = models.CharField(max_length=40, null=True, blank=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    viewed_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user if self.user else self.session_key} viewed {self.product.name}"


# ── Coupon System ────────────────────────────────────────────────────────────
class Coupon(models.Model):
    code = models.CharField(max_length=50, unique=True, help_text="Coupon code (e.g. SAVE20)")
    discount_percentage = models.DecimalField(
        max_digits=5, decimal_places=2,
        help_text="Discount percentage (1-100)"
    )
    min_order_amount = models.DecimalField(
        max_digits=10, decimal_places=2, default=0,
        help_text="Minimum cart total to apply this coupon"
    )
    max_uses = models.PositiveIntegerField(default=0, help_text="0 = unlimited uses")
    times_used = models.PositiveIntegerField(default=0, editable=False)
    is_active = models.BooleanField(default=True)
    valid_from = models.DateTimeField(default=timezone.now)
    valid_to = models.DateTimeField(null=True, blank=True, help_text="Leave blank = never expires")
    created_at = models.DateTimeField(auto_now_add=True)

    def is_valid(self, cart_total=0):
        """Returns (True, '') if valid, or (False, error_message)."""
        from decimal import Decimal
        cart_total = Decimal(str(cart_total))
        if not self.is_active:
            return False, "This coupon is inactive."
        if timezone.now() < self.valid_from:
            return False, "This coupon is not yet active."
        if self.valid_to and timezone.now() > self.valid_to:
            return False, "This coupon has expired."
        if self.max_uses > 0 and self.times_used >= self.max_uses:
            return False, "This coupon has reached its usage limit."
        if cart_total < self.min_order_amount:
            return False, f"Minimum order amount of ₹{self.min_order_amount} required."
        return True, ""

    def apply(self, cart_total):
        """Returns discount amount for the given cart total."""
        from decimal import Decimal
        cart_total = Decimal(str(cart_total))
        discount = (cart_total * self.discount_percentage) / Decimal('100')
        return round(discount, 2)

    def __str__(self):
        return f"{self.code} ({self.discount_percentage}% OFF)"

    class Meta:
        ordering = ['-created_at']
