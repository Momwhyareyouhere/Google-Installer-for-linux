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

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        exit 1
    fi
}

check_system() {
    if ! grep -qE "(debian|ubuntu)" /etc/os-release; then
        exit 1
    fi
}

install_chrome() {
    read -p "Do you want to proceed? (Y/N): " choice

    if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
        sudo apt remove -y firefox
        sudo rm -Rf /usr/bin/firefox
        sudo rm -Rf /usr/local/firefox
        sudo snap remove firefox

        wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb
        sudo dpkg -i google-chrome.deb
        sudo apt --fix-broken install -y

        rm google-chrome.deb
    elif [[ "$choice" == "N" || "$choice" == "n" ]]; then
        exit 0
    else
        exit 1
    fi
}

download_script "https://raw.githubusercontent.com/Momwhyareyouhere/Google-Installer-for-linux/refs/heads/main/setup.sh" "setup.sh"
download_script "https://raw.githubusercontent.com/Momwhyareyouhere/Google-Installer-for-linux/refs/heads/main/restore.sh" "restore.sh"

chmod +x "$DOWNLOAD_DIR/setup.sh" "$DOWNLOAD_DIR/restore.sh"
clear
sudo bash "$DOWNLOAD_DIR/setup.sh"

check_root
check_system


rm -- "$0"
