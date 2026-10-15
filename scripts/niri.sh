#!/usr/bin/env bash
set -euo pipefail

echo 'deb http://download.opensuse.org/repositories/home:/AvengeMedia:/danklinux/Debian_Testing/ /' | sudo tee /etc/apt/sources.list.d/home:AvengeMedia:danklinux.list
curl -fsSL https://download.opensuse.org/repositories/home:AvengeMedia:danklinux/Debian_Testing/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_AvengeMedia_danklinux.gpg > /dev/null
sudo apt update
sudo apt install niri alacritty swaylock kanshi fonts-font-awesome -y #mako, waybar, swayidle, swaybg, pavucontrol, wl-clipboard, brightnessctl, grim/slurp, nwg-drawer, nwg-panel, nwg-displays
