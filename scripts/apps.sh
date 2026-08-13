#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

if [[ "${SETUP:-}" != "1" ]]; then
    sudo apt update -y
fi

sudo apt install -y $(xargs < "${PROJECT_DIR}/packages/pentest.txt")
