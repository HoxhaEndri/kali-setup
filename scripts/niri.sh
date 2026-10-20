#!/usr/bin/env bash
set -euo pipefail

if ! command -v niri >/dev/null 2>&1; then
    sudo apt install rustup gcc clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev libxcb-cursor-dev -y
    rustup default stable
    cargo install cargo-deb
    git clone https://github.com/YaLTeR/niri.git ~/
    ( cd ~/niri && cargo deb && sudo apt install ./target/debian/niri_*_amd64.deb )
fi

if ! command -v xwayland-satellite >/dev/null 2>&1; then
    git clone https://github.com/Supreeeme/xwayland-satellite.git ~/
    ( cd ~/xwayland-satellite && cargo deb && sudo apt install ./target/debian/xwayland-satellite_*_amd64.deb )
fi

sudo apt update -y && sudo apt install alacritty swaylock kanshi fonts-font-awesome xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring -y #mako, waybar, swayidle, swaybg, pavucontrol, wl-clipboard, brightnessctl, grim/slurp, nwg-drawer, nwg-panel, nwg-displays
