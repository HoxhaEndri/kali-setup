#!/usr/bin/env bash
set -euo pipefail

CONFIG_SOURCE="$HOME/dotfiles/.config"
CONFIG_DEST="$HOME/.config"

if ! command -v niri >/dev/null 2>&1; then
    sudo apt install rustup gcc clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev libxcb-cursor-dev -y
    rustup default stable
    cargo install cargo-deb
    git clone https://github.com/YaLTeR/niri.git "$HOME/niri"
    ( cd ~/niri && cargo deb && sudo apt install ./target/debian/niri_*_amd64.deb )
    sudo rm -r "$HOME/niri"
fi

if ! command -v xwayland-satellite >/dev/null 2>&1; then
    git clone https://github.com/Supreeeme/xwayland-satellite.git "$HOME/xwayland-satellite"
    ( cd ~/xwayland-satellite && cargo deb && sudo apt install ./target/debian/xwayland-satellite_*_amd64.deb )
    sudo rm -r "$HOME/xwayland-satellite"
fi

sudo apt update -y && sudo apt install alacritty swaylock swayidle waybar kanshi fonts-font-awesome xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring polkit-kde-agent-1 wl-mirror wl-clipboard -y #mako, swaybg, pavucontrol, brightnessctl, grim/slurp, nwg-drawer, nwg-panel, nwg-displays


if [ ! -d "$HOME/.config/kanshi" ]; then
    git clone https://github.com/HoxhaEndri/dotfiles.git "$HOME/dotfiles"
    mkdir -p "$CONFIG_DEST"
    for config in "$CONFIG_SOURCE"/*/; do
        [ -d "$config" ] || continue
        name=$(basename "$config")
        mkdir -p "$CONFIG_DEST/$name"
        cp -r "$config". "$CONFIG_DEST/$name/"
    done
    rm -rf "$HOME/dotfiles"
    systemctl --user add-wants niri.service swayidle.service
    systemctl --user add-wants niri.service waybar.service
fi


