"""Small HTML helpers (stdlib only)."""

import json
import re


def extract_jsonld(html: str) -> list[dict]:
    """Extract all JSON-LD blocks from HTML."""
    out = []
    for m in re.finditer(
        r'<script[^>]*type=["\']application/ld\+json["\'][^>]*>(.*?)</script>',
        html,
        re.S | re.I,
    ):
        raw = m.group(1).strip()
        try:
            data = json.loads(raw)
        except (json.JSONDecodeError, ValueError):
            continue
        if isinstance(data, list):
            out.extend(x for x in data if isinstance(x, dict))
        elif isinstance(data, dict):
            # handle @graph
            if "@graph" in data and isinstance(data["@graph"], list):
                out.extend(x for x in data["@graph"] if isinstance(x, dict))
            else:
                out.append(data)
    return out


def meta(html: str, prop: str) -> str | None:
    """Read a meta tag content by property/name."""
    for attr in ("property", "name"):
        m = re.search(
            rf'<meta[^>]*{attr}=["\']{re.escape(prop)}["\'][^>]*content=["\']([^"\']*)["\']',
            html,
            re.I,
        )
        if m:
            return m.group(1)
        m = re.search(
            rf'<meta[^>]*content=["\']([^"\']*)["\'][^>]*{attr}=["\']{re.escape(prop)}["\']',
            html,
            re.I,
        )
        if m:
            return m.group(1)
    return None


def canonical_url(html: str, fallback: str | None = None) -> str | None:
    m = re.search(r'<link[^>]*rel=["\']canonical["\'][^>]*href=["\']([^"\']*)["\']', html, re.I)
    if m:
        return m.group(1)
    m = re.search(r'<link[^>]*href=["\']([^"\']*)["\'][^>]*rel=["\']canonical["\']', html, re.I)
    if m:
        return m.group(1)
    return fallback


def find_product_jsonld(html: str) -> dict | None:
    for d in extract_jsonld(html):
        t = d.get("@type")
        types = t if isinstance(t, list) else [t]
        if any(str(x).lower() == "product" for x in types):
            return d
    return None


def stock_from_availability(value) -> str | None:
    if value is None:
        return None
    s = str(value).lower()
    if "instock" in s or "in_stock" in s or "in stock" in s:
        return "in_stock"
    if "outofstock" in s or "out_of_stock" in s or "out of stock" in s:
        return "out_of_stock"
    if "preorder" in s:
        return "pre_order"
    return s
