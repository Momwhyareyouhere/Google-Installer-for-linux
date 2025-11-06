#!/bin/bash

DOWNLOAD_DIR="./Google-Installer-for-Linux"

mkdir -p "$DOWNLOAD_DIR"

download_script() {
    local url=$1
    local filename=$2

    if [ ! -f "$DOWNLOAD_DIR/$filename" ]; then
        wget "$url" -O "$DOWNLOAD_DIR/$filename"
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
}




download_script "https://raw.githubusercontent.com/Momwhyareyouhere/Google-Installer-for-linux/refs/heads/main/setup.sh" "setup.sh"
download_script "https://raw.githubusercontent.com/Momwhyareyouhere/Google-Installer-for-linux/refs/heads/main/restore.sh" "restore.sh"

chmod +x "$DOWNLOAD_DIR/setup.sh" "$DOWNLOAD_DIR/restore.sh"
clear
sudo bash "$DOWNLOAD_DIR/setup.sh"




rm -- "$0"
