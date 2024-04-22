#!/bin/sh

hostname=$(cat /etc/hostname)
exec Hyprland --config $HOME/.config/hypr/$hostname.conf
