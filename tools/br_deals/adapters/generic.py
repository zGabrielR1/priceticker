"""Generic JSON-LD-first adapter shared by BR retailers."""

from __future__ import annotations

import re

from ..html import (
    find_product_jsonld,
    meta,
    canonical_url,
    stock_from_availability,
)
from ..models import NormalizedProduct
from ..price import parse_brl


class JsonLdAdapter:
    def __init__(self, domain: str, price_selectors: list[str] | None = None):
        self.domain = domain
        self.price_selectors = price_selectors or []

    def parse(self, html: str, url: str) -> NormalizedProduct:
        p = find_product_jsonld(html)
        title = None
        cash = None
        image = None
        availability = None
        offers = None
        if p:
            title = p.get("name")
            image = p.get("image")
            if isinstance(image, list):
                image = image[0] if image else None
            offers = p.get("offers")
            if isinstance(offers, list):
                offers = offers[0] if offers else None
            if isinstance(offers, dict):
                cash = parse_brl(offers.get("price"))
                availability = stock_from_availability(offers.get("availability"))
        # meta fallbacks
        if not title:
            title = meta(html, "og:title") or meta(html, "twitter:title")
        if cash is None:
            for prop in ("product:price:amount", "og:price:amount", "twitter:data1"):
                v = meta(html, prop)
                if v:
                    cash = parse_brl(v)
                    if cash is not None:
                        break
        if cash is None:
            for sel in self.price_selectors:
                m = re.search(sel, html, re.I)
                if m:
                    cash = parse_brl(m.group(1) if m.groups() else m.group(0))
                    if cash is not None:
                        break
        if not image:
            image = meta(html, "og:image")
        if availability is None:
            availability = stock_from_availability(meta(html, "product:availability"))
        # installment / shipping / seller / coupon via meta or regex (best-effort)
        installment = None
        m = re.search(r"(\d+)\s*x\s*(?:de\s*)?R?\$?\s*([\d\.,]+)", html, re.I)
        if m:
            try:
                installment = parse_brl(m.group(2))
            except Exception:
                installment = None
        shipping = None
        ms = re.search(r"frete[^<]*?R\$\s*([\d\.,]+)", html, re.I)
        if ms:
            shipping = parse_brl(ms.group(1))
        seller = None
        coupon = None
        mc = re.search(r"cupom[:\s]*([A-Z0-9\-]+)", html, re.I)
        if mc:
            coupon = mc.group(1)
        return NormalizedProduct(
            title=title,
            cash_price=cash,
            installment_price=installment,
            shipping=shipping,
            stock=availability,
            seller=seller,
            coupon=coupon,
            canonical_url=canonical_url(html, url),
            raw={"image": image},
        )

    def fetch_product(self, url: str) -> NormalizedProduct:
        # Network not implemented in skeleton; callers pass saved HTML to parse().
        raise NotImplementedError("fetch_product requires a transport; use parse() on saved HTML")

    def search(self, query: str):
        raise NotImplementedError("search not implemented in skeleton")
