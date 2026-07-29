from django.http import JsonResponse
from store.models import Product, UserActivity

# Cross-sell rules (Category Keyword -> Recommended Keywords)
CROSS_SELL_RULES = {
    'ac': ['stabilizer', 'fan', 'air cooler'],
    'air conditioner': ['stabilizer', 'fan', 'air cooler'],
    'refrigerator': ['inverter', 'stabilizer'],
    'washing machine': ['detergent', 'stand'],
    'tv': ['wall mount', 'soundbar'],
    'television': ['wall mount', 'soundbar'],
}

def get_product_recommendations(product, limit=5):
    """
    Suggests related products from same category or cross-selling.
    """
    recommended_products = []
    category_name = product.categories.name.lower() if product.categories else ""
    
    # 1. Cross-selling Check
    cross_sell_keywords = []
    for key, values in CROSS_SELL_RULES.items():
        if key in category_name:
            cross_sell_keywords.extend(values)
            
    if cross_sell_keywords:
        from django.db.models import Q
        q_objects = Q()
        for kw in cross_sell_keywords:
            q_objects |= Q(name__icontains=kw) | Q(categories__name__icontains=kw) | Q(subcategories__name__icontains=kw)
            
        cross_sells = Product.objects.filter(q_objects, status='PUBLISH').exclude(id=product.id).order_by('-id')[:limit]
        recommended_products.extend(list(cross_sells))
        
    # 2. Add Same Category products if we need more
    if len(recommended_products) < limit:
        same_cat = Product.objects.filter(categories=product.categories, status='PUBLISH').exclude(id=product.id)
        existing_ids = [p.id for p in recommended_products]
        same_cat = same_cat.exclude(id__in=existing_ids).order_by('-id')[:limit - len(recommended_products)]
        recommended_products.extend(list(same_cat))
        
    return recommended_products

def get_user_recommendations(user, session_key=None, session_cart=None, limit=5):
    """
    Recommend products based on user behavior (views, cart, past orders).
    """
    product_ids = set()
    
    # A. Recenetly Viewed
    if user and user.is_authenticated:
        recent_views = UserActivity.objects.filter(user=user).order_by('-viewed_at')[:8]
    elif session_key:
        recent_views = UserActivity.objects.filter(session_key=session_key).order_by('-viewed_at')[:8]
    else:
        recent_views = []
        
    for rv in recent_views:
        product_ids.add(rv.product.id)
        
    # B. Cart Items
    if session_cart:
        for p_key, p_val in session_cart.items():
            try:
                pid = p_val.get('product_id') or p_key
                product_ids.add(int(pid))
            except (ValueError, TypeError):
                pass
                
    # C. Previous Orders
    if user and user.is_authenticated:
        from store.models import Orderitem
        past_items = Orderitem.objects.filter(order__user=user).order_by('-id')[:10]
        # Match by name
        product_names = [pi.product for pi in past_items]
        past_products = Product.objects.filter(name__in=product_names)
        for p in past_products:
            product_ids.add(p.id)
            
    # Process Recommendations
    seed_products = Product.objects.filter(id__in=product_ids)
    
    recommended = []
    for p in seed_products:
        recs = get_product_recommendations(p, limit=3)
        for r in recs:
            if r.id not in product_ids and r not in recommended:
                recommended.append(r)
                if len(recommended) >= limit:
                    break
        if len(recommended) >= limit:
            break
            
    # Fallback to popular or newest products if empty
    if len(recommended) < limit:
        # Avoid including any product we already have or have seen
        exclude_ids = [p.id for p in recommended] + list(product_ids)
        fallback = Product.objects.filter(status='PUBLISH').exclude(id__in=exclude_ids).order_by('?')[:limit - len(recommended)]
        recommended.extend(list(fallback))
        
    return recommended

# --- API Endpoints ---

def api_product_recommendations(request, id):
    try:
        product = Product.objects.get(id=id)
        recs = get_product_recommendations(product, limit=5)
        
        data = []
        for p in recs:
            data.append({
                'id': p.id,
                'name': p.name,
                'price': str(p.get_discounted_price()),
                'original_price': str(p.price),
                'discount_pct': float(p.discount_percentage) if p.discount_percentage else 0,
                'image': p.image.url if p.image else '',
                'url': f'/Details/{p.id}',
                'category': p.categories.name if p.categories else '',
                'rating': 'N/A' # Will enhance if reviews are included
            })
            
        return JsonResponse({'status': 'success', 'recommendations': data})
    except Product.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Product not found'}, status=404)

def api_user_recommendations(request):
    user = request.user if request.user.is_authenticated else None
    
    if not request.session.session_key:
        request.session.create()
    session_key = request.session.session_key
    cart = request.session.get('cart', {})
    
    recs = get_user_recommendations(user, session_key=session_key, session_cart=cart, limit=5)
    
    data = []
    for p in recs:
        data.append({
            'id': p.id,
            'name': p.name,
            'price': str(p.get_discounted_price()),
            'original_price': str(p.price),
            'discount_pct': float(p.discount_percentage) if p.discount_percentage else 0,
            'image': p.image.url if p.image else '',
            'url': f'/Details/{p.id}',
            'category': p.categories.name if p.categories else '',
            'rating': 'N/A'
        })
        
    return JsonResponse({'status': 'success', 'recommendations': data})
