from django.contrib import admin
from .models import *


# ── Coupon Admin ──────────────────────────────────────────────────────────
class CouponAdmin(admin.ModelAdmin):
    list_display = ('code', 'discount_percentage', 'min_order_amount', 'max_uses',
                    'times_used', 'is_active', 'valid_from', 'valid_to')
    list_editable = ('is_active',)
    search_fields = ('code',)
    list_filter = ('is_active',)


class ImageInline(admin.TabularInline):
    model = images


class ProductAdmin(admin.ModelAdmin):
    inlines = [ImageInline]
    list_display = ('name', 'price', 'discount_percentage', 'is_deal_of_day',
                    'offer_expiry', 'is_offer_active', 'status')
    list_editable = ('discount_percentage', 'is_deal_of_day', 'offer_expiry')
    list_filter = ('is_deal_of_day', 'status', 'categories')
    search_fields = ('name',)

    def is_offer_active(self, obj):
        return obj.is_offer_active()
    is_offer_active.boolean = True
    is_offer_active.short_description = 'Offer Active?'


class CustomUserAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'first_name', 'last_name', 'is_staff', 'gender', 'contact', 'address')
    search_fields = ['username']

    def gender(self, obj):
        return obj.profile.gender

    def contact(self, obj):
        return obj.profile.contact

    def address(self, obj):
        return obj.profile.address


class OrderitemTubleinline(admin.TabularInline):
    model = Orderitem
    extra = 0

class OrderStatusHistoryInline(admin.TabularInline):
    model = OrderStatusHistory
    extra = 0


class OrderAdmin(admin.ModelAdmin):
    inlines = [OrderitemTubleinline, OrderStatusHistoryInline]
    list_display = ('id', 'user', 'status', 'orderdate', 'delivery_date', 'is_cancelled', 'cancel_reason')
    list_editable = ('status', 'delivery_date', 'is_cancelled')
    search_fields = ['firstname', 'user__username', 'id']
    list_filter = ('status', 'is_cancelled', 'payment_method')


admin.site.register(images)
admin.site.register(Categories)
admin.site.register(SubCategories)
admin.site.register(Filter_Price)
admin.site.register(Product, ProductAdmin)
admin.site.unregister(User)
admin.site.register(User, CustomUserAdmin)
admin.site.register(contact_us)
admin.site.register(Order, OrderAdmin)
admin.site.register(Review)
admin.site.register(Wishlist)
admin.site.register(Coupon, CouponAdmin)