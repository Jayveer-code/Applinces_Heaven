from decimal import Decimal, InvalidOperation

from django import template

register = template.Library()


@register.filter(name='multiply')
def multiply(value, arg):
    """Line total helper used by checkout and order templates."""
    try:
        return Decimal(str(value)) * Decimal(str(arg))
    except (InvalidOperation, TypeError, ValueError):
        return Decimal('0')
