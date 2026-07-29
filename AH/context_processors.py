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

def categories_processor(request):
    return {
        'all_categories': Categories.objects.all(),
        'all_subcategories': SubCategories.objects.all(),
    }
