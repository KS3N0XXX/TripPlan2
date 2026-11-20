#!/bin/zsh
set -eu
cd -- "${0:A:h}"

exec python3 - <<'PY'
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from subprocess import run

handler = partial(SimpleHTTPRequestHandler, directory="site")
with ThreadingHTTPServer(("127.0.0.1", 8080), handler) as server:
    url = "http://127.0.0.1:8080/"
    print(f"TripPlan: {url}\nДля остановки нажмите Ctrl+C.", flush=True)
    run(["open", url], check=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
PY
