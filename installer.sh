#!/bin/bash

if [ ! -f setup.sh ]; then
    echo "setup.sh not found! Downloading..."
    wget https://raw.githubusercontent.com/Momwhyareyouhere/Google-Installer-for-linux/refs/heads/main/setup.sh
    if [ $? -ne 0 ]; then
        echo "Failed to download setup.sh."
        exit 1
    fi
fi

if [ ! -f restore.sh ]; then
    echo "restore.sh not found! Downloading..."
    wget https://raw.githubusercontent.com/Momwhyareyouhere/Google-Installer-for-linux/refs/heads/main/restore.sh
    if [ $? -ne 0 ]; then
        echo "Failed to download restore.sh."
        exit 1
    fi
fi

chmod +x setup.sh restore.sh

echo "Running setup.sh..."
sudo bash setup.sh
