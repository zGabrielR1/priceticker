"""Pichau adapter."""

from .generic import JsonLdAdapter


class PichauAdapter(JsonLdAdapter):
    def __init__(self):
        super().__init__(
            "pichau.com.br",
            price_selectors=[r'"price"\s*:\s*"?([\d\.,]+)"?'],
        )
