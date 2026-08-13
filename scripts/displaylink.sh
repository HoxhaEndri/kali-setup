#!/usr/bin/env bash
set -euo pipefail

if [[ "${SETUP:-}" != "1" ]]; then
    echo "[+] Updating the system..."
    sudo apt update -y && sudo apt upgrade -y
    sudo apt full-upgrade -y
fi

RUNNING_KERNEL="$(uname -r)"

echo "[+] Running kernel: ${RUNNING_KERNEL}"

# Check whether headers for the running kernel are installed.
if dpkg-query -W -f='${Status}' "linux-headers-${RUNNING_KERNEL}" 2>/dev/null \
    | grep -q "install ok installed"; then

    echo "[+] Headers for ${RUNNING_KERNEL} are installed."

else
    echo "[!] Headers for ${RUNNING_KERNEL} are not installed."

    # Check whether the exact headers are available from APT.
    if apt-cache show "linux-headers-${RUNNING_KERNEL}" >/dev/null 2>&1; then
        echo "[+] Installing headers for ${RUNNING_KERNEL}..."
        sudo apt install -y "linux-headers-${RUNNING_KERNEL}"
    else
        echo "[!] Headers for ${RUNNING_KERNEL} are not available."

        # Find the newest installed kernel.
        INSTALLED_KERNEL="$(
            ls -1 /lib/modules 2>/dev/null |
            sort -V |
            tail -n1
        )"

        if [[ -n "${INSTALLED_KERNEL}" &&
              "${INSTALLED_KERNEL}" != "${RUNNING_KERNEL}" ]]; then

            echo
            echo "[!] A newer kernel is installed:"
            echo "[!] Running kernel:  ${RUNNING_KERNEL}"
            echo "[!] Installed kernel: ${INSTALLED_KERNEL}"
            echo
            echo "[!] Please reboot into ${INSTALLED_KERNEL}"
            echo "[!] and run this script again."
            exit 1
        fi

        echo
        echo "[!] No matching kernel headers are available."
        echo "[!] Cannot install DisplayLink."
        exit 1
    fi
fi

RUNNING_KERNEL="$(uname -r)"
LATEST_KERNEL="$(ls -1 /lib/modules | sort -V | tail -n1)"

if [[ "$RUNNING_KERNEL" != "$LATEST_KERNEL" ]]; then
    echo "[!] The installed kernel is newer than the running kernel."
    echo "[!] Running:  $RUNNING_KERNEL"
    echo "[!] Installed: $LATEST_KERNEL"
    echo
    echo "[!] Reboot is required before installing DisplayLink."
    exit 1
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
sudo bash /tmp/displaylink/displaylink-driver-*.run --accept
sudo rm -r /tmp/displaylink
sudo rm /tmp/driver.zip
echo "Displaylink script finished."
