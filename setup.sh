#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "Please do NOT run this script as root."
    echo "Run it as a normal user. You will be prompted for sudo when needed."
    exit 1
fi

if grep -qiE "debian|ubuntu" /etc/os-release; then
    OS="debian"
elif grep -qi "arch" /etc/os-release; then
    OS="arch"
else
    echo "Unsupported distribution."
    exit 1
fi

echo "This script will uninstall Firefox and install Google Chrome."
read -p "Do you want to proceed? (Y/N): " choice

if [[ ! "$choice" =~ ^[Yy]$ ]]; then
    echo "Exiting."
    exit 0
fi

if [ "$OS" = "debian" ]; then
    echo "Detected Debian/Ubuntu system."

    sudo apt update
    sudo apt remove -y firefox firefox-esr
    sudo snap remove firefox 2>/dev/null
    sudo rm -rf /usr/bin/firefox
    sudo rm -rf /usr/local/firefox

    echo "Downloading Google Chrome..."
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb

    sudo dpkg -i google-chrome.deb
    sudo apt --fix-broken install -y

    rm -f google-chrome.deb

    echo "Google Chrome installed successfully on Debian/Ubuntu."

elif [ "$OS" = "arch" ]; then
    echo "Detected Arch Linux system."

    sudo pacman -Rns --noconfirm firefox 2>/dev/null

    if ! pacman -Qi git &>/dev/null; then
        echo "Installing git..."
        sudo pacman -S --noconfirm git
    fi

    if ! pacman -Qg base-devel &>/dev/null; then
        echo "Installing base-devel..."
        sudo pacman -S --needed --noconfirm base-devel
    fi

    echo "Cloning Google Chrome AUR repository..."
    git clone https://aur.archlinux.org/google-chrome.git

    cd google-chrome || exit 1

    echo "Building and installing Google Chrome..."
    makepkg -si --noconfirm

    cd ..
    rm -rf google-chrome

    echo "Google Chrome installed successfully on Arch Linux."
fi

echo "All done."
