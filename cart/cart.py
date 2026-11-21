from django.conf import settings


class Cart:
    """Session-backed shopping cart used by checkout, cart detail, and the header count."""

    def __init__(self, request):
        self.session = request.session
        cart = self.session.get(settings.CART_SESSION_ID)
        if not cart:
            cart = self.session[settings.CART_SESSION_ID] = {}
        self.cart = cart

    def add(self, product, unit_price=None, quantity=1, update_quantity=False):
        product_id = str(product.id)
        if unit_price is None:
            unit_price = getattr(product, 'get_discounted_price', lambda: product.price)()

        image = ''
        if getattr(product, 'image', None):
            try:
                image = product.image.url
            except ValueError:
                image = ''

        if product_id not in self.cart:
            self.cart[product_id] = {
                'product_id': product.id,
                'name': product.name,
                'quantity': 0,
                'price': str(unit_price),
                'image': image,
            }

        if update_quantity:
            self.cart[product_id]['quantity'] = int(quantity)
        else:
            self.cart[product_id]['quantity'] += int(quantity)

        self.cart[product_id]['price'] = str(unit_price)
        self.save()

    def save(self):
        self.session[settings.CART_SESSION_ID] = self.cart
        self.session.modified = True

    def remove(self, product):
        product_id = str(product.id)
        if product_id in self.cart:
            del self.cart[product_id]
            self.save()

    def decrement(self, product):
        product_id = str(product.id)
        if product_id not in self.cart:
            return
        self.cart[product_id]['quantity'] -= 1
        if self.cart[product_id]['quantity'] < 1:
            self.remove(product)
        else:
            self.save()

    def clear(self):
        self.session[settings.CART_SESSION_ID] = {}
        self.cart = self.session[settings.CART_SESSION_ID]
        self.session.modified = True

    def __iter__(self):
        for item in self.cart.values():
            yield item

    def __len__(self):
        return sum(int(item.get('quantity', 0)) for item in self.cart.values())
