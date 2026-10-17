"""Normalized data classes for the Brazilian deal adapters."""

from dataclasses import dataclass, field
from typing import Optional


@dataclass(frozen=True)
class NormalizedProduct:
    """Normalized product fields extracted by an adapter."""

    title: Optional[str] = None
    cash_price: Optional[float] = None  # cash / PIX price in BRL
    installment_price: Optional[float] = None
    shipping: Optional[float] = None
    stock: Optional[str] = None
    seller: Optional[str] = None
    coupon: Optional[str] = None
    canonical_url: Optional[str] = None
    raw: dict = field(default_factory=dict)

    def __post_init__(self) -> None:
        for name in ("cash_price", "installment_price", "shipping"):
            v = getattr(self, name)
            if v is not None and v < 0:
                raise ValueError(f"{name} must be >= 0, got {v}")
