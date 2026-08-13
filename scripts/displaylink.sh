#!/usr/bin/env bash
set -euo pipefail

if [[ "${SETUP}" != "1" ]]; then
    sudo apt update -y && sudo apt upgrade -y
fi

BASE_URL="https://www.synaptics.com"
DOWNLOADS_URL="${BASE_URL}/products/displaylink-graphics/downloads/ubuntu"
DRIVER=$(curl -fsSl "${DOWNLOADS_URL}" | grep -A20 'Latest Official Driver' | grep -oP '<a href="\K[^"]+(?="[^>]*class="download-link")')
ACCEPT_URL="${BASE_URL}""${DRIVER}"
ZIP_URL=$(curl -fsSl "${ACCEPT_URL}" | grep -oP '<a class="no-link" href="\K[^"]+(?=" download>Accept</a>)')
ARCHIVE_URL="${BASE_URL}""${ZIP_URL}"
echo "Downloading driver archive..."
curl -fsL -o /tmp/driver.zip "${ARCHIVE_URL}"
echo "Driver archive downloaded."
unzip /tmp/driver.zip -d /tmp/displaylink
sudo chmod +x /tmp/displaylink/displaylink-driver-*.run
yes | sudo bash /tmp/displaylink/displaylink-driver-*.run
sudo rm -r /tmp/displaylink
sudo rm /tmp/driver.zip
echo "Displaylink script finished."
