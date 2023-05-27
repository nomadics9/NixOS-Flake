#!/usr/bin/env bash
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/nix/store/hcxlp6vsl99bg24sac286i209m0xbj32-xdg-desktop-portal-hyprland-0.pre+date=2023-04-25_c0e2339/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
