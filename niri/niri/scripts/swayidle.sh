#!/bin/sh
swayidle -w\
 timeout 1070 'swaylock -f -C ~/.config/swaylock/config' \
 timeout 770 'niri msg action power-off-monitors' \
 before-sleep 'swaylock -f -C ~/.config/swaylock/config'
