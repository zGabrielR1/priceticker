"""Source activation must require real, available, priced catalog offers."""
import unittest
from probe_discovery_sources import CANDIDATES, build_endpoint, verify


class ProbeTest(unittest.TestCase):
    def test_build_endpoint_bounds_the_slice_and_encodes_the_term(self):
        endpoint = build_endpoint("https://www.hering.com.br", "placa de video")
        self.assertEqual(
            "https://www.hering.com.br/api/catalog_system/pub/products/search"
            "?ft=placa%20de%20video&_from=0&_to=9",
            endpoint,
        )

    def test_every_candidate_is_a_display_name_https_origin_and_term(self):
        # Guards against future edits adding a 2-tuple, http origin, or empty term.
        # The 3-tuple shape is what main() unpacks.
        self.assertGreaterEqual(len(CANDIDATES), 3, "probe should always carry multiple categories")
        for source_id, entry in CANDIDATES.items():
            with self.subTest(source=source_id):
                name, origin, term = entry
                self.assertIsInstance(name, str) and self.assertTrue(name)
                self.assertTrue(origin.startswith("https://"), f"origin must be https: {origin}")
                self.assertIsInstance(term, str) and self.assertTrue(term.strip())
                endpoint = build_endpoint(origin, term)
                self.assertTrue(endpoint.startswith(origin + "/api/catalog_system/"))
                self.assertIn("_from=0&_to=9", endpoint)

    def test_accepts_actual_price_and_stock(self):
        self.assertEqual(1, verify([{
            "productName": "RTX", "linkText": "rtx", "items": [{
                "itemId": "123", "sellers": [{"sellerId": "1", "commertialOffer": {
                    "Price": 90, "AvailableQuantity": 1,
                }}],
            }],
        }]))

    def test_does_not_enable_empty_blocked_or_out_of_stock_sources(self):
        for payload in ([], {"error": "blocked"}, "<html>blocked</html>", [{
            "productName": "RTX", "linkText": "rtx", "items": [{
                "itemId": "123", "sellers": [{"sellerId": "1", "commertialOffer": {
                    "Price": 90, "AvailableQuantity": 0,
                }}],
            }],
        }]):
            with self.assertRaises(ValueError):
                verify(payload)
