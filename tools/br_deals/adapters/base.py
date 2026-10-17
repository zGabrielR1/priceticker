"""Adapter interface contract."""

from __future__ import annotations

from typing import Protocol, Iterable

from ..models import NormalizedProduct


class Adapter(Protocol):
    """One adapter per retailer domain."""

    domain: str

    def search(self, query: str) -> Iterable[NormalizedProduct]:
        """Search the retailer for a query; yield normalized products."""
        ...

    def fetch_product(self, url: str) -> NormalizedProduct:
        """Fetch and parse a single product page."""
        ...

    def parse(self, html: str, url: str) -> NormalizedProduct:
        """Parse saved HTML into normalized fields."""
        ...
