"""Verify bounded retailer catalogs before enabling them; no credentials required."""
from __future__ import annotations

import argparse
import json
import urllib.error
import urllib.request
from pathlib import Path

CANDIDATES = {
    "carrefour-gpu": ("Carrefour", "https://www.carrefour.com.br"),
    "ibyte-gpu": ("Ibyte", "https://www.ibyte.com.br"),
    "fastshop-gpu": ("Fast Shop", "https://www.fastshop.com.br"),
    "nagem-gpu": ("Nagem", "https://www.nagem.com.br"),
}


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


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
    for source, (name, origin) in CANDIDATES.items():
        endpoint = origin + "/api/catalog_system/pub/products/search?ft=placa%20de%20video&_from=0&_to=9"
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
