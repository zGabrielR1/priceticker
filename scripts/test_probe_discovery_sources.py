"""Source activation must require real, available, priced catalog offers."""
import unittest
from probe_discovery_sources import verify


class ProbeTest(unittest.TestCase):
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
