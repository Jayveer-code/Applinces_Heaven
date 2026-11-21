from django.conf import settings
from store.models import Categories, SubCategories, Wishlist

def wishlist_count(request):
    count = 0
    wishlist_items = []
    if request.user.is_authenticated:
        wishlist_items = Wishlist.objects.filter(user=request.user)
        count = wishlist_items.count()
    return {
        'wishlist_count': count,
        'wishlist_items': wishlist_items,
    }

def cart_count(request):
    cart = request.session.get(getattr(settings, 'CART_SESSION_ID', 'cart'), {}) or {}
    count = 0
    for item in cart.values():
        try:
            count += int(item.get('quantity', 0))
        except (TypeError, ValueError, AttributeError):
            count += 1
    return {'cart_count': count}


def categories_processor(request):
    return {
        'all_categories': Categories.objects.all(),
        'all_subcategories': SubCategories.objects.all(),
    }
