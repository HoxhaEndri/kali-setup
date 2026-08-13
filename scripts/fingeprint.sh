#!/usr/bin/env bash
set -euo pipefail

if [[ "${SETUP}" != "1" ]]; then
    sudo apt update -y
fi

echo "Installing fingerprint support..."
sudo apt install -y fprintd libpam-fprintd

echo "Enabling fingerprint authentication..."
# https://gitlab.freedesktop.org/libfprint/libfprint
# supported devices: https://fprint.freedesktop.org/supported-devices.html
sudo pam-auth-update --enable fprintd
echo "Fingerprint PAM configuration complete."
