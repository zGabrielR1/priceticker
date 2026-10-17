"""Sinks for ingestion output (stdlib only)."""

from __future__ import annotations

import json
import urllib.request
from typing import Callable, Optional


class InMemorySink:
    def __init__(self):
        self.items: list = []

    def __call__(self, payload):
        self.items.append(payload)
        return True


class HttpSink:
    """POST JSON to an API endpoint; fail safe when unconfigured."""

    def __init__(self, url: Optional[str] = None, transport: Optional[Callable] = None):
        self.url = url
        self.transport = transport or urllib.request.urlopen

    def __call__(self, payload):
        if not self.url:
            return False
        data = json.dumps(payload, default=str).encode("utf-8")
        req = urllib.request.Request(self.url, data=data, headers={"Content-Type": "application/json"})
        try:
            with self.transport(req) as resp:
                return getattr(resp, "status", 200) < 400
        except Exception:
            return False
