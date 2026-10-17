import os
import sys
import time
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from br_deals.ratelimit import RateLimiter, detect_block, QuarantinedError


class TestRateLimit(unittest.TestCase):
    def test_acquire_and_success(self):
        rl = RateLimiter(min_interval=0.0)
        rl.acquire("example.com")
        rl.record_success("example.com")
        self.assertFalse(rl.is_quarantined("example.com"))

    def test_quarantine_after_failures(self):
        rl = RateLimiter(min_interval=0.0, max_failures=2, quarantine_seconds=10.0)
        rl.acquire("example.com")
        rl.record_failure("example.com")
        rl.record_failure("example.com")
        self.assertTrue(rl.is_quarantined("example.com"))
        with self.assertRaises(QuarantinedError):
            rl.acquire("example.com")

    def test_detect_block(self):
        self.assertEqual(detect_block("<html>captcha here</html>", 200), "captcha:captcha")
        self.assertEqual(detect_block("ok", 403), "http_403")
        self.assertIsNone(detect_block("<html>" + "x" * 300 + "</html>", 200))


if __name__ == "__main__":
    unittest.main()
