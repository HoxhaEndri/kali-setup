#!/usr/bin/env bash
set -euo pipefail

export SETUP=1

echo "[+] Updating the system..."
sudo apt update -y
sudo apt upgrade -y
sudo apt full-upgrade -y

echo "[+] Executing scripts..."

for script in ./scripts/*.sh; do
    [[ -f "$script" ]] || continue

    echo "========================================"
    echo "[+] Running: $(basename "$script")"
    echo "========================================"

    bash "$script"
done

echo "[+] All scripts completed."
