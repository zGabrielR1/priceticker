import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from br_deals.price import parse_brl


class TestPrice(unittest.TestCase):
    def test_parse(self):
        cases = [
            ("R$ 1.234,56", 1234.56),
            ("1.234,56", 1234.56),
            ("1234,56", 1234.56),
            ("R$ 99,90", 99.9),
            ("99.90", 99.9),
            (None, None),
            ("", None),
            ("abc", None),
            ("R$ 0,00", 0.0),
        ]
        for inp, exp in cases:
            self.assertEqual(parse_brl(inp), exp, msg=inp)


if __name__ == "__main__":
    unittest.main()
