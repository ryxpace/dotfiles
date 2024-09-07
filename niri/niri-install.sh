#!/bin/bash

username="$(logname)"

# Check for sudo
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi

# Install the custom package list
echo "Installing needed packages..."
pacman -S --noconfirm --noprogressbar --needed --disable-download-timeout $(< packages-repository.txt)

# Deploy user configs
echo "Deploying user configs..."
rsync -a .config "/home/${username}/"
rsync -a home_config/ "/home/${username}/"
# Restore user ownership
chown -R "${username}:${username}" "/home/${username}"

# Deploy system configs
echo "Deploying system configs..."
rsync -a --chown=root:root etc/ /etc/

# Enable the Greetd service
echo "Enabling the Greetd service..."
systemctl -f enable greetd.service

# Remove the repo
echo "Removing the EOS Community Sway repo..."
rm -rf ../../dotfiles

echo "Installation complete."
