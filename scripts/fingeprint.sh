#!/usr/bin/env bash
set -euo pipefail

echo "Installing fingerprint support..."

sudo apt update -y
sudo apt install -y fprintd libpam-fprintd

echo "Enabling fingerprint authentication..."
# https://gitlab.freedesktop.org/libfprint/libfprint
# supported devices: https://fprint.freedesktop.org/supported-devices.html
sudo pam-auth-update --enable fprintd
echo "Fingerprint PAM configuration complete."
