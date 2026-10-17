"""Explainable deal engine (stdlib only)."""

from __future__ import annotations

import statistics
from dataclasses import dataclass
from typing import Iterable


@dataclass(frozen=True)
class DealResult:
    is_deal: bool
    reason: str
    adjusted_price: float
    percentile: float | None  # fraction of history below adjusted_price
    is_record_low: bool
    confidence: float  # 0..1
    explanation: str


def adjusted_price(cash: float, shipping: float = 0.0, coupon: float = 0.0) -> float:
    """Coupon-adjusted and shipping-adjusted price."""
    return max(0.0, cash + (shipping or 0.0) - (coupon or 0.0))


def percentile_rank(history: Iterable[float], value: float) -> float | None:
    """Fraction of history strictly below value (0..1). None if no history."""
    hs = [h for h in history if h is not None]
    if not hs:
        return None
    below = sum(1 for h in hs if h < value)
    return below / len(hs)


def is_record_low(history: Iterable[float], value: float) -> bool:
    hs = [h for h in history if h is not None]
    if not hs:
        return True
    return value <= min(hs)


def fake_discount(history: Iterable[float], claimed_original: float | None, current: float) -> bool:
    """Heuristic: claimed original far above observed max suggests fake discount."""
    hs = [h for h in history if h is not None]
    if not hs or claimed_original is None:
        return False
    observed_max = max(hs)
    # claimed original more than 20% above anything ever observed
    return claimed_original > observed_max * 1.2 and current < claimed_original * 0.9


def evaluate(
    *,
    cash_price: float,
    history: Iterable[float],
    shipping: float = 0.0,
    coupon: float = 0.0,
    median_30d: float | None = None,
    median_90d: float | None = None,
    min_pct_below_30d: float | None = None,
    min_pct_below_90d: float | None = None,
    max_price: float | None = None,
    record_low_only: bool = False,
    claimed_original: float | None = None,
) -> DealResult:
    adj = adjusted_price(cash_price, shipping, coupon)
    hs = [h for h in history if h is not None]
    pct = percentile_rank(hs, adj)
    record = is_record_low(hs, adj)
    fake = fake_discount(hs, claimed_original, adj)

    reasons: list[str] = []
    is_deal = True

    if max_price is not None and adj > max_price:
        is_deal = False
        reasons.append(f"price {adj:.2f} above max {max_price:.2f}")

    if record_low_only and not record:
        is_deal = False
        reasons.append("not a record low")

    if min_pct_below_30d is not None and median_30d:
        threshold = median_30d * (1 - min_pct_below_30d / 100.0)
        if adj > threshold:
            is_deal = False
            reasons.append(
                f"{(1 - adj / median_30d) * 100:.0f}% below 30-day median required "
                f"({min_pct_below_30d:.0f}%), got {(1 - adj / median_30d) * 100:.0f}%"
            )

    if min_pct_below_90d is not None and median_90d:
        threshold = median_90d * (1 - min_pct_below_90d / 100.0)
        if adj > threshold:
            is_deal = False
            reasons.append(
                f"{(1 - adj / median_90d) * 100:.0f}% below 90-day median required "
                f"({min_pct_below_90d:.0f}%)"
            )

    if fake:
        is_deal = False
        reasons.append("suspected fake discount (claimed original above observed max)")

    # confidence: based on history depth + percentile extremity
    depth = min(1.0, len(hs) / 30.0)
    extremity = 0.0 if pct is None else (1.0 - pct)
    confidence = round(0.4 * depth + 0.6 * extremity, 3)
    if len(hs) < 5:
        confidence = min(confidence, 0.4)

    # explainable summary
    parts = []
    if median_90d:
        parts.append(f"{(1 - adj / median_90d) * 100:.0f}% below 90-day median")
    if record:
        parts.append("record low")
    if fake:
        parts.append("fake-discount suspected")
    explanation = "; ".join(parts) if parts else "no historical context"

    if is_deal:
        reason = "deal: " + explanation
    else:
        reason = "not a deal: " + "; ".join(reasons)

    return DealResult(
        is_deal=is_deal,
        reason=reason,
        adjusted_price=adj,
        percentile=pct,
        is_record_low=record,
        confidence=confidence,
        explanation=explanation,
    )
