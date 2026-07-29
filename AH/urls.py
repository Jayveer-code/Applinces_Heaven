"""
URL configuration for AH project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from AH import views
from AH import admin_views
from AH import chatbot_views
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.Main,name="HomePage"),
    path('Login/', views.LoginPage,name="LoginPage"),
    path('invoice_page/', views.invoice_page,name="invoice_page"),
    path('Contact/', views.ContactPage,name="ContactPage"),
    path('About/', views.AboutPage,name="AboutPage"),
    path('Cart/', views.CartPage,name="CartPage"),
    path('Chekout/', views.CheckoutPage,name="ChekoutPage"),
    path('thankyou/', views.thankyou,name="thankyou"),
    path('ChangePass/', views.ForgotPage,name="ChangePass"),
    path('Product/', views.PRODUCT,name="Productpage"),
    path('regstore/', views.regstore,name="regstore"),
    path('registration/', views.registration,name="registration"),
    path('login_check/', views.login_check,name="login_check"),
    path('logout/', views.logout,name="logout"),
    path('payment_process/', views.payment_process,name="payment_process"),
    path('success/', views.success,name="success"),
    path('orderhistory/', views.orderhistory,name="orderhistory"),
    path('orderview/<int:id>', views.orderview,name="orderview"),
    path('track-order/', views.track_order, name='track_order'),
    path('order-cancel/<int:order_id>/', views.order_cancel, name='order_cancel'),
    path('related/', views.related,name="related"),
    path('profile/', views.profile,name="profile"),
    path('profile_address/', views.profile_address,name="profile_address"),
    path('profile_edit/<int:id>', views.profile_edit,name="profile_edit"),
    path('profile_update/<int:id>', views.profile_update,name="profile_update"),
    path('update_password/', views.update_password,name="update_password"),
    path('placeorder/', views.placeorder,name="placeorder"),
    path('search/', views.search,name="search"),
    path('Details/<int:id>', views.DetailsPage,name="DetailsPage"),
    path('add-review/<int:product_id>/', views.add_review, name='add_review'),
    path('wishlist/add/<int:product_id>/', views.wishlist_add, name='wishlist_add'),
    path('wishlist/remove/<int:product_id>/', views.wishlist_remove, name='wishlist_remove'),
    path('wishlist/', views.wishlist_list, name='wishlist_list'),
    path('cart/add/<int:id>/', views.cart_add, name='cart_add'),
    path('cart/item_clear/<int:id>/', views.item_clear, name='item_clear'),
    path('cart/item_increment/<int:id>/', views.item_increment, name='item_increment'),
    path('cart/item_decrement/<int:id>/',views.item_decrement, name='item_decrement'),
    path('cart/cart_clear/', views.cart_clear, name='cart_clear'),
    path('cart/cart_deatail/',views.cart_detail,name='cart_detail'),
    path('cart/apply-coupon/', views.apply_coupon, name='apply_coupon'),
    path('cart/remove-coupon/', views.remove_coupon, name='remove_coupon'),
    path('verify-otp/', views.verify_otp, name='verify_otp'),
    path('resend-otp/', views.resend_otp, name='resend_otp'),
    path('password_reset/', auth_views.PasswordResetView.as_view(template_name='registration/password_reset.html'), name='password_reset'),
    path('password_reset/done/', auth_views.PasswordResetDoneView.as_view(template_name='registration/password_reset_done.html'), name='password_reset_done'),
    path('password-reset-confirm/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(template_name='registration/password_reset_confirm.html'), name='password_reset_confirm'),
    path('reset/done/', auth_views.PasswordResetCompleteView.as_view(template_name='registration/password_reset_complete.html'), name='password_reset_complete'),

    # ── Custom Admin Panel ────────────────────────────────────────────────
    path('admin-panel/login/',                   admin_views.admin_login,             name='admin_login'),
    path('admin-panel/logout/',                  admin_views.admin_logout,            name='admin_logout'),
    path('admin-panel/',                         admin_views.admin_dashboard,         name='admin_dashboard'),
    path('admin-panel/dashboard/',               admin_views.admin_dashboard,         name='admin_dashboard_alt'),

    # Products
    path('admin-panel/products/',                admin_views.admin_products,          name='admin_products'),
    path('admin-panel/products/add/',            admin_views.admin_product_add,       name='admin_product_add'),
    path('admin-panel/products/bulk-upload/',     admin_views.admin_product_bulk_upload, name='admin_product_bulk_upload'),
    path('admin-panel/products/<int:pk>/edit/',  admin_views.admin_product_edit,      name='admin_product_edit'),
    path('admin-panel/products/<int:pk>/delete/',admin_views.admin_product_delete,    name='admin_product_delete'),

    # Categories
    path('admin-panel/categories/',              admin_views.admin_categories,        name='admin_categories'),
    path('admin-panel/categories/add/',          admin_views.admin_category_add,      name='admin_category_add'),
    path('admin-panel/categories/<int:pk>/edit/',admin_views.admin_category_edit,     name='admin_category_edit'),
    path('admin-panel/categories/<int:pk>/delete/',admin_views.admin_category_delete, name='admin_category_delete'),
    path('admin-panel/subcategories/add/',       admin_views.admin_subcategory_add,   name='admin_subcategory_add'),
    path('admin-panel/subcategories/<int:pk>/edit/', admin_views.admin_subcategory_edit, name='admin_subcategory_edit'),
    path('admin-panel/subcategories/<int:pk>/delete/', admin_views.admin_subcategory_delete, name='admin_subcategory_delete'),

    # Orders
    path('admin-panel/orders/',                  admin_views.admin_orders,            name='admin_orders'),
    path('admin-panel/orders/<int:pk>/',         admin_views.admin_order_detail,      name='admin_order_detail'),

    # Users
    path('admin-panel/users/',                   admin_views.admin_users,             name='admin_users'),
    path('admin-panel/users/<int:pk>/',          admin_views.admin_user_detail,       name='admin_user_detail'),
    path('admin-panel/users/<int:pk>/toggle/',   admin_views.admin_user_toggle,       name='admin_user_toggle'),

    # Coupons
    path('admin-panel/coupons/',                 admin_views.admin_coupons,           name='admin_coupons'),
    path('admin-panel/coupons/add/',             admin_views.admin_coupon_add,        name='admin_coupon_add'),
    path('admin-panel/coupons/<int:pk>/edit/',   admin_views.admin_coupon_edit,       name='admin_coupon_edit'),
    path('admin-panel/coupons/<int:pk>/delete/', admin_views.admin_coupon_delete,     name='admin_coupon_delete'),

    # Reports
    path('admin-panel/reports/',                 admin_views.admin_reports,           name='admin_reports'),

    # Reviews
    path('admin-panel/reviews/',                         admin_views.admin_reviews,              name='admin_reviews'),
    path('admin-panel/reviews/<int:pk>/delete/',         admin_views.admin_review_delete,        name='admin_review_delete'),

    # Wishlists
    path('admin-panel/wishlists/',                       admin_views.admin_wishlists,            name='admin_wishlists'),
    path('admin-panel/wishlists/<int:pk>/delete/',       admin_views.admin_wishlist_delete,      name='admin_wishlist_delete'),

    # Contact Us
    path('admin-panel/contacts/',                        admin_views.admin_contacts,             name='admin_contacts'),
    path('admin-panel/contacts/<int:pk>/',               admin_views.admin_contact_detail,       name='admin_contact_detail'),
    path('admin-panel/contacts/<int:pk>/delete/',        admin_views.admin_contact_delete,       name='admin_contact_delete'),

    # Filter Price
    path('admin-panel/filter-prices/',                   admin_views.admin_filter_prices,        name='admin_filter_prices'),
    path('admin-panel/filter-prices/add/',               admin_views.admin_filter_price_add,     name='admin_filter_price_add'),
    path('admin-panel/filter-prices/<int:pk>/edit/',     admin_views.admin_filter_price_edit,    name='admin_filter_price_edit'),
    path('admin-panel/filter-prices/<int:pk>/delete/',   admin_views.admin_filter_price_delete,  name='admin_filter_price_delete'),

    # Product Extra Images
    path('admin-panel/products/<int:product_pk>/images/',        admin_views.admin_product_images,       name='admin_product_images'),
    path('admin-panel/product-images/<int:pk>/delete/',          admin_views.admin_product_image_delete, name='admin_product_image_delete'),

    # ── ElectroBot AI Chatbot ─────────────────────────────────────────────
    path('chatbot/',          chatbot_views.electrobot_page, name='electrobot_page'),
    path('chatbot/chat/',     chatbot_views.electrobot_chat, name='electrobot_chat'),
    
]


if settings.DEBUG:
    urlpatterns+=static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
