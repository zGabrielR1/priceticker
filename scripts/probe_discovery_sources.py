"""Verify bounded retailer catalogs before enabling them; no credentials required."""
from __future__ import annotations

import argparse
import json
import urllib.error
import urllib.request
from pathlib import Path
from urllib.parse import quote

# Each candidate carries its own bounded search term so the probe is not tied to
# one product category. The slice stays 10 products; a term is what makes the
# slice representative of that retailer. Verified live 2026-11-02.
CANDIDATES = {
    "ibyte-gpu": ("Ibyte", "https://www.ibyte.com.br", "placa de video"),
    "hering-apparel": ("Hering", "https://www.hering.com.br", "camisa"),
    "olympikus-footwear": ("Olympikus", "https://www.olympikus.com.br", "tenis"),
    "farm-apparel": ("Farm", "https://www.farmrio.com.br", "vestido"),
    "puket-hosiery": ("Puket", "https://www.puket.com.br", "meia"),
    "karsten-home": ("Karsten", "https://www.karsten.com.br", "toalha"),
    "multilaser-electronics": ("Multilaser", "https://www.multilaser.com.br", "fone"),
    "carrefour-gpu": ("Carrefour", "https://www.carrefour.com.br", "placa de video"),
    "fastshop-gpu": ("Fast Shop", "https://www.fastshop.com.br", "placa de video"),
    "nagem-gpu": ("Nagem", "https://www.nagem.com.br", "placa de video"),
    "drogasil-pharmacy": ("Drogasil", "https://www.drogasil.com.br", "vitamina"),
    "centauro-sports": ("Centauro", "https://www.centauro.com.br", "tenis"),
}


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


def build_endpoint(origin: str, term: str) -> str:
    """Bounded first-page VTEX catalog search for the term (never full catalog)."""
    return (origin + "/api/catalog_system/pub/products/search"
            + f"?ft={quote(term)}&_from=0&_to=9")


def verify(payload: object) -> int:
    if not isinstance(payload, list) or len(payload) > 50:
        raise ValueError("Expected a bounded VTEX catalog array")
    available = 0
    for product in payload:
        if not isinstance(product, dict):
            raise ValueError("Expected product objects")
        if not product.get("productName") or not product.get("linkText"):
            continue
        for item in product.get("items", []):
            for seller in item.get("sellers", []):
                offer = seller.get("commertialOffer", {})
                price = offer.get("Price")
                quantity = offer.get("AvailableQuantity", 0)
                if (item.get("itemId") and seller.get("sellerId")
                        and isinstance(price, (int, float)) and price > 0
                        and isinstance(quantity, (int, float)) and quantity > 0):
                    available += 1
    if not available:
        raise ValueError("No in-stock priced offers in this product slice")
    return available


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, default=Path("source-probe"))
    args = parser.parse_args()
    args.out.mkdir(parents=True, exist_ok=True)
    opener = urllib.request.build_opener(NoRedirect())
    verified = {}
    results = []
    for source, (name, origin, term) in CANDIDATES.items():
        endpoint = build_endpoint(origin, term)
        result = {"id": source, "endpoint": endpoint, "verified": False}
        try:
            request = urllib.request.Request(endpoint, headers={
                "Accept": "application/json", "User-Agent": "PriceTicker/1.1 catalog verification",
            })
            with opener.open(request, timeout=20) as response:
                body = response.read(5_000_001)
                if len(body) > 5_000_000:
                    raise ValueError("Catalog exceeds 5 MB")
                payload = json.loads(body)
            result["available_offers"] = verify(payload)
            result["verified"] = True
            (args.out / (source + ".json")).write_text(json.dumps(payload), encoding="utf-8")
            verified[source] = {"name": name, "driver": "vtex", "origin": origin,
                                "endpoint": endpoint, "interval_seconds": 300}
        except (urllib.error.URLError, ValueError, OSError, TypeError, KeyError) as error:
            result["error"] = str(error)
        results.append(result)
        print(json.dumps(result), flush=True)
    (args.out / "results.json").write_text(json.dumps(results, indent=2), encoding="utf-8")
    (args.out / "verified-sources.json").write_text(json.dumps(verified, indent=2), encoding="utf-8")
    return 0 if verified else 1


if __name__ == "__main__":
    raise SystemExit(main())
