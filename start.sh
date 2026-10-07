#!/bin/sh
# Starts AIS on http://localhost:8765 so the Negotiation Desk can be reached.
cd "$(dirname "$0")"
(command -v open >/dev/null && open http://localhost:8765) || (command -v xdg-open >/dev/null && xdg-open http://localhost:8765) || true
exec python3 -m http.server 8765 --bind 127.0.0.1
