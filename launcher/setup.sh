#!/bin/bash
# Script install encoding changer in XFCE panel launcher
# Usefull for VNC copy-paste from linux to linux non English encodings
chown -R $(id -u):$(id -g) .
cp -pR launcher-18 ~/.config/xfce4/panel/
sudo cp -p *utf8*.sh /usr/local/sbin/
