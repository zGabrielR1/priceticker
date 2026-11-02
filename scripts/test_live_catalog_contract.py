"""A live VTEX snapshot must satisfy the PHP CatalogAdapter normalization contract."""
import json
import re
import unittest
from pathlib import Path

SNAPSHOT = Path(__file__).parent / "fixtures" / "ibyte_catalog_snapshot.json"
# Mirrors CatalogAdapter.php: catalog path without query, fragment, percent escapes or traversal.
PATH_RE = re.compile(r"^/[a-zA-Z0-9/_%.+\-]+$")
ORIGIN_RE = re.compile(r"^https://[a-z0-9.-]+$", re.IGNORECASE)
MAX_OFFERS = 500


def normalize_vtex(payload, origin):
    if not isinstance(payload, list):
        raise ValueError("Expected a VTEX catalog array.")
    rows = []
    for product in payload:
        for sku in product.get("items") or []:
            for seller in sku.get("sellers") or []:
                offer = seller.get("commertialOffer") or {}
                rows.append({
                    "sku": f"{sku.get('itemId', '')}:{seller.get('sellerId', '')}",
                    "title": product.get("productName") or "",
                    "path": "/" + (product.get("linkText") or "") + "/p",
                    "price": offer.get("Price", 0),
                    "available": (offer.get("AvailableQuantity") or 0) > 0,
                })
    if not origin_match(origin):
        raise ValueError("Source origin must be an HTTPS retailer hostname.")
    if len(rows) > MAX_OFFERS:
        raise ValueError("Too many offers.")
    for row in rows:
        require_row(row)
        row["url"] = origin.rstrip("/") + row["path"]
    return rows


def origin_match(origin):
    return bool(ORIGIN_RE.match(origin))


def require_row(row):
    sku = row["sku"]
    # Activation gate is stricter than the receiver: real SKU and seller identities are required.
    if (not isinstance(sku, str) or not re.match(r"^[^:]+:[^:]+$", sku) or len(sku) > 160):
        raise ValueError("Bad sku.")
    if not isinstance(row["title"], str) or not row["title"] or len(row["title"]) > 255:
        raise ValueError("Bad title.")
    path = row["path"]
    if (not isinstance(path, str) or not path or len(path) > 2000
            or not PATH_RE.match(path) or ".." in path or "%" in path
            or path.startswith("//")):
        raise ValueError("Bad path.")
    price = row["price"]
    if isinstance(price, bool) or not isinstance(price, (int, float)) or not (0 <= price <= 9999999999.99):
        raise ValueError("Bad price.")
    if not isinstance(row["available"], bool):
        raise ValueError("Bad availability.")
    if row["available"] and float(price) <= 0:
        raise ValueError("An available offer must have a positive price.")


class LiveCatalogContractTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.payload = json.loads(SNAPSHOT.read_text(encoding="utf-8"))

    def test_real_ibyte_payload_normalizes_and_passes_the_php_contract(self):
        rows = normalize_vtex(self.payload, "https://www.ibyte.com.br")
        self.assertGreaterEqual(len(rows), 10)
        self.assertTrue(all(r["url"].startswith("https://www.ibyte.com.br/") for r in rows))
        self.assertTrue(all(r["available"] and r["price"] > 0 for r in rows))

    def test_probe_verify_agrees_with_the_adapter_on_the_same_snapshot(self):
        from probe_discovery_sources import verify
        self.assertGreaterEqual(verify(self.payload), 10)

    def test_rejects_payloads_the_php_adapter_rejects(self):
        for bad in (
            {"products": []},
            [{"productName": "X", "linkText": "x?utm=1", "items": [{"itemId": "1", "sellers": [
                {"sellerId": "1", "commertialOffer": {"Price": 10, "AvailableQuantity": 1}}]}]}],
            [{"productName": "X", "linkText": "..%2Fsecret", "items": [{"itemId": "1", "sellers": [
                {"sellerId": "1", "commertialOffer": {"Price": 10, "AvailableQuantity": 1}}]}]}],
        ):
            with self.assertRaises(ValueError, msg=str(bad)[:80]):
                normalize_vtex(bad, "https://www.ibyte.com.br")

    def test_zero_price_is_accepted_only_when_the_offer_is_unavailable(self):
        payload = [{"productName": "X", "linkText": "x", "items": [{"itemId": "1", "sellers": [
            {"sellerId": "1", "commertialOffer": {"Price": 0, "AvailableQuantity": 0}}]}]}]
        self.assertFalse(normalize_vtex(payload, "https://www.ibyte.com.br")[0]["available"])

    def test_unrecognized_offer_fields_do_not_change_normalization(self):
        payload = [{"productName": "X", "linkText": "x", "items": [{"itemId": "1", "sellers": [
            {"sellerId": "1", "commertialOffer": {"Price": 10, "AvailableQuantity": 1, "extra": "?q=1"}}]}]}]
        row = normalize_vtex(payload, "https://www.ibyte.com.br")[0]
        self.assertEqual(row["sku"], "1:1")
        self.assertEqual(row["url"], "https://www.ibyte.com.br/x/p")


if __name__ == "__main__":
    unittest.main()
