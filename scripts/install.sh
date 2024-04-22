#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Installing packages"
pacman -S - < ./packages.txt

echo "Adding Hyprland-Script wayland session"
chmod +x ./hyprland.sh
cp ./hyprland.sh /usr/local/bin/
cp ./hyprland-script.desktop /usr/share/wayland-sessions/
