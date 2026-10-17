import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

RSS = """<?xml version="1.0"?>
<rss version="2.0"><channel>
  <item>
    <title>Mouse Gamer Logitech G Pro - R$ 299,90</title>
    <link>https://www.kabum.com.br/produto/123/mouse?utm_source=rss</link>
    <description>Por R$ 299,90 (de R$ 399,90)</description>
  </item>
  <item>
    <title>Mouse Gamer Logitech G Pro - R$ 299,90</title>
    <link>https://www.kabum.com.br/produto/123/mouse</link>
    <description>Por R$ 299,90</description>
  </item>
  <item>
    <title>Teclado Redragon - R$ 189,90</title>
    <link>https://www.pichau.com.br/teclado</link>
    <description>Por R$ 189,90</description>
  </item>
</channel></rss>
"""

from br_deals.ingestion import fetch_rss, dedupe, identify_store, validate_discount, match_watches, Pipeline
from br_deals.sinks import InMemorySink


class TestIngestion(unittest.TestCase):
    def test_fetch_rss(self):
        items = fetch_rss(RSS, source="pelando")
        self.assertEqual(len(items), 3)
        self.assertEqual(items[0].price, 299.90)

    def test_dedupe(self):
        items = fetch_rss(RSS)
        deduped = dedupe(items)
        self.assertEqual(len(deduped), 2)

    def test_identify_store(self):
        items = fetch_rss(RSS)
        it = identify_store(items[0], {"kabum.com.br": "KaBuM"})
        self.assertEqual(it.store, "KaBuM")

    def test_validate_discount(self):
        self.assertTrue(validate_discount(
            __import__("br_deals.ingestion", fromlist=["FeedItem"]).FeedItem(title="x", url="u", price=80.0, store="s"),
            [100.0] * 5, 10.0,
        ))
        self.assertFalse(validate_discount(
            __import__("br_deals.ingestion", fromlist=["FeedItem"]).FeedItem(title="x", url="u", price=99.0, store="s"),
            [100.0] * 5, 10.0,
        ))

    def test_match_watches(self):
        watches = [{"id": "w1", "config": {"keywords": ["logitech"]}, "rules": {"store_allowlist": ["kabum.com.br"]}}]
        from br_deals.ingestion import FeedItem
        it = FeedItem(title="Mouse Logitech", url="https://www.kabum.com.br/x", price=10.0, store="kabum.com.br")
        self.assertEqual(match_watches(it, watches), ["w1"])

    def test_pipeline_end_to_end(self):
        sink = InMemorySink()
        watches = [{"id": "w1", "config": {"keywords": ["logitech"]}, "rules": {}}]
        pipe = Pipeline(domain_map={"kabum.com.br": "KaBuM"}, min_pct=10.0, sink=sink)
        res = pipe.run([RSS], watches, history_lookup=lambda it: [399.90] * 5)
        self.assertEqual(len(res.items), 2)
        self.assertTrue(any("logitech" in (m[0].title or "").lower() for m in res.matched))
        self.assertGreaterEqual(len(sink.items), 1)


if __name__ == "__main__":
    unittest.main()
