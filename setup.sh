#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please run with sudo."
    exit 1
fi

if ! grep -qE "(debian|ubuntu)" /etc/os-release; then
    echo "This script is only supported on Debian or Ubuntu systems."
    exit 1
fi

echo "This script uninstalls Firefox and installs Google Chrome."
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

    echo "Done, Google Chrome has been installed."

elif [[ "$choice" == "N" || "$choice" == "n" ]]; then
    echo "Exiting the script."
    exit 0
else
    echo "Invalid choice. Please run the script again and choose Y or N."
    exit 1
fi
