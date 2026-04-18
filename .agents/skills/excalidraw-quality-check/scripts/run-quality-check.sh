#!/usr/bin/env bash
set -euo pipefail

# Run from repo root (parent of .agents)
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"

if [ ! -f "$ROOT/package.json" ]; then
  echo "excalidraw-quality-check: package.json not found at $ROOT — are you in the monorepo?" >&2
  exit 1
fi

cd "$ROOT"

echo "==> Excalidraw quality check (from $ROOT)"
yarn test:all
