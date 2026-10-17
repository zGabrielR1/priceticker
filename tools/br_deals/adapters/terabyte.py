"""Terabyte adapter."""

from .generic import JsonLdAdapter


class TerabyteAdapter(JsonLdAdapter):
    def __init__(self):
        super().__init__(
            "terabyteshop.com.br",
            price_selectors=[r'"price"\s*:\s*"?([\d\.,]+)"?'],
        )
