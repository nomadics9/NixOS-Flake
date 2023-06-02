#!/usr/bin/env bash
sleep 2
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/nix/store/n54257gv8i05n7mh57qyrg555m5ymxdg-xdg-desktop-portal-hyprland-0.pre+date=2023-05-29_4d9ff0c/libexec/xdg-desktop-portal-hyprland &
sleep 3
/nix/store/dvwkf9i5vyffqs6bn001ili2f94nrqx8-xdg-desktop-portal-1.16.0/libexec/xdg-desktop-portal &



