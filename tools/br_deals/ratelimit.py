"""Per-domain rate limiting, backoff, CAPTCHA/block detection, quarantine."""

from __future__ import annotations

import time
from collections import defaultdict, deque
from dataclasses import dataclass, field


@dataclass
class DomainState:
    last_request: float = 0.0
    failures: int = 0
    quarantined_until: float = 0.0
    recent: deque = field(default_factory=lambda: deque(maxlen=100))


class RateLimiter:
    """Token-bucket-ish per-domain limiter with backoff and quarantine."""

    def __init__(self, min_interval: float = 1.0, max_failures: int = 3, quarantine_seconds: float = 300.0):
        self.min_interval = min_interval
        self.max_failures = max_failures
        self.quarantine_seconds = quarantine_seconds
        self.state: dict[str, DomainState] = defaultdict(DomainState)

    def acquire(self, domain: str) -> None:
        st = self.state[domain]
        now = time.monotonic()
        if now < st.quarantined_until:
            raise QuarantinedError(domain, st.quarantined_until - now)
        wait = st.last_request + self.min_interval - now
        if wait > 0:
            time.sleep(wait)
        st.last_request = time.monotonic()

    def record_success(self, domain: str) -> None:
        self.state[domain].failures = 0

    def record_failure(self, domain: str, reason: str = "") -> None:
        st = self.state[domain]
        st.failures += 1
        if st.failures >= self.max_failures:
            st.quarantined_until = time.monotonic() + self.quarantine_seconds

    def is_quarantined(self, domain: str) -> bool:
        return time.monotonic() < self.state[domain].quarantined_until


class QuarantinedError(Exception):
    def __init__(self, domain: str, remaining: float):
        super().__init__(f"domain {domain} quarantined for {remaining:.1f}s")
        self.domain = domain
        self.remaining = remaining


CAPTCHA_MARKERS = (
    "captcha",
    "cf-challenge",
    "just a moment",
    "access denied",
    "unusual traffic",
    "verify you are human",
    "robot check",
)


def detect_block(html: str, status_code: int = 200) -> str | None:
    """Return a block reason string if the response looks blocked/CAPTCHA, else None."""
    if status_code in (403, 429, 503):
        return f"http_{status_code}"
    low = (html or "").lower()
    for marker in CAPTCHA_MARKERS:
        if marker in low:
            return f"captcha:{marker}"
    if len(low.strip()) < 200 and status_code == 200:
        return "empty_page"
    return None
