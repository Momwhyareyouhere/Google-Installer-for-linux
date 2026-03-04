#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please run with sudo."
    exit 1
fi

if grep -qiE "(debian|ubuntu)" /etc/os-release; then
    echo "Detected Debian/Ubuntu system."
    apt update
    apt install -y firefox

elif grep -qi "arch" /etc/os-release; then
    echo "Detected Arch Linux system."
    pacman -Sy --noconfirm firefox

else
    echo "This script is only supported on Debian, Ubuntu, or Arch Linux systems."
    exit 1
fi

echo "Done, Firefox has been restored."
