#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please run with sudo."
    exit 1
fi

if ! grep -qE "(debian|ubuntu)" /etc/os-release; then
    echo "This script is only supported on Debian or Ubuntu systems."
    exit 1
fi

sudo apt update
sudo apt install -y firefox

echo "Done, Firefox has been restored."
