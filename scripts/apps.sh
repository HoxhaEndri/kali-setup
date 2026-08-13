#!/usr/bin/env bash
set -euo pipefail

if [[ "${SETUP:-}" != "1" ]]; then
    sudo apt update -y
fi

sudo apt install -y $(xargs < ../packages/pentest.txt)
