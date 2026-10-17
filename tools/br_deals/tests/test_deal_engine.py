import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from br_deals.deal_engine import evaluate, adjusted_price, is_record_low


class TestDealEngine(unittest.TestCase):
    def test_adjusted_price(self):
        self.assertEqual(adjusted_price(100.0, shipping=10.0, coupon=5.0), 105.0)

    def test_record_low(self):
        self.assertTrue(is_record_low([10.0, 20.0], 5.0))
        self.assertFalse(is_record_low([10.0, 20.0], 15.0))

    def test_deal_below_90d_median(self):
        history = [100.0] * 10
        r = evaluate(cash_price=80.0, history=history, median_90d=100.0, min_pct_below_90d=15.0)
        self.assertTrue(r.is_deal)
        self.assertIn("below 90-day median", r.explanation)

    def test_not_deal_above_threshold(self):
        history = [100.0] * 10
        r = evaluate(cash_price=95.0, history=history, median_90d=100.0, min_pct_below_90d=15.0)
        self.assertFalse(r.is_deal)

    def test_fake_discount(self):
        history = [100.0] * 10
        r = evaluate(cash_price=90.0, history=history, claimed_original=500.0, median_90d=100.0)
        self.assertFalse(r.is_deal)
        self.assertIn("fake", r.reason)

    def test_record_low_only(self):
        history = [50.0, 60.0]
        r = evaluate(cash_price=55.0, history=history, record_low_only=True)
        self.assertFalse(r.is_deal)

    def test_confidence_low_history(self):
        r = evaluate(cash_price=80.0, history=[100.0, 100.0], median_90d=100.0)
        self.assertLessEqual(r.confidence, 0.4)


if __name__ == "__main__":
    unittest.main()
