#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt upgrade -y
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst cpu-checker virt-manager

sudo usermod -aG libvirt $(whoami)
sudo usermod -aG kvm $(whoami)

sudo systemctl start libvirtd
sudo systemctl enable libvirtd

sudo apt install -y virt-viewer spice-vdagent spice-html5
sudo apt install -y gir1.2-spiceclientgtk-3.0 qemu-system-gui
