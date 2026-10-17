import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from br_deals.adapters.kabum import KabumAdapter
from br_deals.adapters.pichau import PichauAdapter
from br_deals.adapters.terabyte import TerabyteAdapter


def load(name):
    base = os.path.join(os.path.dirname(__file__), "..", "fixtures")
    with open(os.path.join(base, name), encoding="utf-8") as f:
        return f.read()


class TestAdapters(unittest.TestCase):
    def test_kabum(self):
        html = load("kabum.html")
        p = KabumAdapter().parse(html, "https://www.kabum.com.br/produto/123/mouse")
        self.assertEqual(p.title, "Mouse Gamer Logitech G Pro X")
        self.assertEqual(p.cash_price, 299.90)
        self.assertEqual(p.stock, "in_stock")
        self.assertEqual(p.canonical_url, "https://www.kabum.com.br/produto/123/mouse")
        self.assertEqual(p.coupon, "GAMER10")
        self.assertAlmostEqual(p.shipping, 19.90)

    def test_pichau(self):
        html = load("pichau.html")
        p = PichauAdapter().parse(html, "https://www.pichau.com.br/teclado-redragon")
        self.assertEqual(p.title, "Teclado Mecanico Redragon")
        self.assertEqual(p.cash_price, 189.90)
        self.assertEqual(p.stock, "out_of_stock")

    def test_terabyte(self):
        html = load("terabyte.html")
        p = TerabyteAdapter().parse(html, "https://www.terabyteshop.com.br/ssd")
        self.assertEqual(p.title, "SSD NVMe 1TB Kingston")
        self.assertEqual(p.cash_price, 349.99)
        self.assertEqual(p.stock, "in_stock")

    def test_normalized_validation(self):
        from br_deals.models import NormalizedProduct
        with self.assertRaises(ValueError):
            NormalizedProduct(cash_price=-1)


if __name__ == "__main__":
    unittest.main()
