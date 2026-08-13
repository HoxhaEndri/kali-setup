#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/Tools
cd ~/Tools

if [[ "${SETUP:-}" != "1" ]]; then
    sudo apt update -y
fi

if ! command -v pip >/dev/null 2>&1; then
    sudo apt install -y python3-pip python3-venv python3-setuptools
fi

if ! command -v pipx >/dev/null 2>&1; then
        sudo apt install -y pipx
fi

if [ ! -d PowerSploit ]; then
    git clone git@github.com:PowerShellMafia/PowerSploit.git
fi

if [ ! -d GraphRunner ]; then
    git clone git@github.com:dafthack/GraphRunner.git
fi

if [ ! -d AADInternals ]; then
    git clone git@github.com:Gerenios/AADInternals.git
fi

if [ ! -d MicroBurst ]; then
    git clone git@github.com:NetSPI/MicroBurst.git
fi

if [ ! -d ScoutSuite ]; then
    git clone https://github.com/nccgroup/ScoutSuite
    cd ScoutSuite
    virtualenv -p python3 venv
    source venv/bin/activate
    pip install -r requirements.txt
    python scout.py --help
fi

if [ ! -d MFASweep ]; then
    git clone git@github.com:dafthack/MFASweep.git
    (cd MFASweep && pip install -r requirements.txt --break-system-packages)
fi

if [ ! -d TokenTacticsV2 ]; then
    git clone git@github.com:f-bader/TokenTacticsV2.git
fi

if ! command -v roadrecon >/dev/null 2>&1; then
    pip install roadrecon --break-system-packages
fi

if ! command -v roadtx >/dev/null 2>&1; then
    pip install roadtx --break-system-packages
fi

if ! command -v azurehound >/dev/null 2>&1; then
    sudo apt install -y azurehound
fi

# Microsoft Azure PowerShell https://github.com/Azure/azure-powershell
if ! command -v pwsh >/dev/null 2>&1; then
    sudo apt install -y powershell
fi

if ! pwsh -NoProfile -Command 'Get-Module -ListAvailable -Name Az' | grep -q .; then
    echo "Azure PowerShell (Az) not installed, installing..."
    pwsh -NoProfile -Command 'Install-Module Az -Scope CurrentUser -Repository PSGallery -Force'
fi

if ! command -v az >/dev/null 2>&1; then
    sudo apt install -y azure-cli
fi

if ! command -v prowler >/dev/null 2>&1; then
    echo "Prowler not found, installing..."
    pipx ensurepath
    pipx install prowler
fi

