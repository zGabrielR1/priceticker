"""Brazilian (BRL) price parsing helpers."""

import re


def parse_brl(value) -> float | None:
    """Parse a Brazilian-formatted price string into a float (BRL).

    Accepts: "R$ 1.234,56", "1.234,56", "1234,56", "R$99,90", "99.90".
    Returns None for blank/unparseable input.
    """
    if value is None:
        return None
    s = str(value).strip()
    if not s:
        return None
    # drop currency symbols, spaces, nbsp
    s = re.sub(r"[R$\s\u00a0]", "", s, flags=re.UNICODE)
    if s in ("", "-", "."):
        return None
    # Brazilian format: dot=thousands, comma=decimal
    if "," in s and "." in s:
        s = s.replace(".", "").replace(",", ".")
    elif "," in s:
        s = s.replace(",", ".")
    s = re.sub(r"[^0-9.\-]", "", s)
    if s in ("", ".", "-"):
        return None
    try:
        return float(s)
    except ValueError:
        return None
