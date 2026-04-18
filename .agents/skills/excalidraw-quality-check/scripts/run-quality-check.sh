#!/usr/bin/env bash
set -euo pipefail

# Run from repo root (parent of .agents)
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
cd "$ROOT"

echo "==> Excalidraw quality check (from $ROOT)"
yarn test:all
