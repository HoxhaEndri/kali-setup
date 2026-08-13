#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/Tools
cd ~/Tools

if [ ! -d PowerSploit ]; then
    git clone git@github.com:PowerShellMafia/PowerSploit.git
fi
