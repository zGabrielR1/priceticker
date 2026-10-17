"""KaBuM adapter."""

from .generic import JsonLdAdapter


class KabumAdapter(JsonLdAdapter):
    def __init__(self):
        super().__init__(
            "kabum.com.br",
            price_selectors=[r'"price"\s*:\s*"?([\d\.,]+)"?'],
        )
