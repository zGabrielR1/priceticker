"""Discovery ingestion pipeline (stdlib only)."""

from __future__ import annotations

import re
import xml.etree.ElementTree as ET
from dataclasses import dataclass, field
from typing import Callable, Iterable, Optional
from urllib.parse import urlparse

from .price import parse_brl


@dataclass(frozen=True)
class FeedItem:
    title: str
    url: str
    price: Optional[float] = None
    original_price: Optional[float] = None
    source: str = ""
    store: Optional[str] = None


def _canonical(url: str) -> str:
    u = urlparse(url)
    return (u.netloc.lower().removeprefix("www.") + u.path.rstrip("/")).lower()


def fetch_rss(xml_text: str, source: str = "") -> list[FeedItem]:
    """Parse RSS/Atom-ish XML text into FeedItems."""
    items: list[FeedItem] = []
    try:
        root = ET.fromstring(xml_text)
    except ET.ParseError:
        return items
    # RSS
    for it in root.iter("item"):
        title = (it.findtext("title") or "").strip()
        link = (it.findtext("link") or "").strip()
        desc = (it.findtext("description") or "").strip()
        price = _price_from_text(desc + " " + title)
        original = None
        m = re.search(r"de\s*R?\$?\s*([\d\.,]+)", desc + " " + title, re.I)
        if m:
            original = parse_brl(m.group(1))
        items.append(FeedItem(title=title, url=link, price=price, original_price=original, source=source))
    # Atom
    ns = {"a": "http://www.w3.org/2005/Atom"}
    for entry in root.findall("a:entry", ns):
        title = (entry.findtext("a:title", default="", namespaces=ns) or "").strip()
        link_el = entry.find("a:link", ns)
        link = link_el.get("href", "") if link_el is not None else ""
        summary = (entry.findtext("a:summary", default="", namespaces=ns) or "").strip()
        price = _price_from_text(summary + " " + title)
        items.append(FeedItem(title=title, url=link, price=price, source=source))
    return items


def _price_from_text(text: str) -> Optional[float]:
    # prefer "R$ 1.234,56" or "por R$..."
    m = re.search(r"R\$\s*([\d\.,]+)", text)
    if m:
        return parse_brl(m.group(1))
    m = re.search(r"([\d]{1,3}(?:\.[\d]{3})*,\d{2})", text)
    if m:
        return parse_brl(m.group(1))
    return None


def dedupe(items: Iterable[FeedItem]) -> list[FeedItem]:
    seen: set[str] = set()
    out: list[FeedItem] = []
    for it in items:
        key = _canonical(it.url) if it.url else it.title.lower()
        if key in seen:
            continue
        seen.add(key)
        out.append(it)
    return out


def identify_store(item: FeedItem, domain_map: dict[str, str] | None = None) -> FeedItem:
    dm = domain_map or {}
    host = _host(item.url)
    store = dm.get(host, host)
    return FeedItem(title=item.title, url=item.url, price=item.price,
                    original_price=item.original_price, source=item.source, store=store)


def _host(url: str) -> str:
    return (urlparse(url).netloc or "").lower().removeprefix("www.")


def validate_discount(item: FeedItem, history: Iterable[float], min_pct: float = 10.0) -> bool:
    """Validate that item.price is at least min_pct below median of history."""
    hs = [h for h in history if h is not None]
    if not hs or item.price is None:
        return False
    med = sorted(hs)[len(hs) // 2]
    if med <= 0:
        return False
    pct = (1 - item.price / med) * 100.0
    return pct >= min_pct


def match_watches(item: FeedItem, watches: Iterable[dict]) -> list[str]:
    """Return ids of watches matching the item (keyword + store allowlist)."""
    out: list[str] = []
    title_low = (item.title or "").lower()
    for w in watches:
        cfg = w.get("config") or {}
        keywords = [k.lower() for k in (cfg.get("keywords") or [])]
        if keywords and not any(k in title_low for k in keywords):
            continue
        allow = (w.get("rules") or {}).get("store_allowlist") or []
        if allow and item.store not in allow:
            continue
        out.append(str(w.get("id")))
    return out


@dataclass
class PipelineResult:
    items: list[FeedItem] = field(default_factory=list)
    matched: list[tuple[FeedItem, list[str]]] = field(default_factory=list)


class Pipeline:
    def __init__(self, domain_map=None, min_pct: float = 10.0, sink: Callable | None = None):
        self.domain_map = domain_map or {}
        self.min_pct = min_pct
        self.sink = sink or (lambda x: None)

    def run(self, xml_texts: Iterable[str], watches: Iterable[dict],
            history_lookup: Callable[[FeedItem], Iterable[float]] | None = None) -> PipelineResult:
        history_lookup = history_lookup or (lambda it: [])
        all_items: list[FeedItem] = []
        for xml in xml_texts:
            all_items.extend(fetch_rss(xml, source="rss"))
        all_items = [identify_store(i, self.domain_map) for i in all_items]
        all_items = dedupe(all_items)
        all_items = [i for i in all_items if i.price is not None]
        result = PipelineResult(items=all_items)
        for it in all_items:
            if not validate_discount(it, history_lookup(it), self.min_pct):
                continue
            matches = match_watches(it, watches)
            if matches:
                result.matched.append((it, matches))
                try:
                    self.sink({"item": it, "watches": matches})
                except Exception:
                    pass
        return result
