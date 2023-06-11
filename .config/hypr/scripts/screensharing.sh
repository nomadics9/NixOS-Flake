#!/usr/bin/env bash
sleep 3
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/nix/store/n1pjbdxr0jiglz5flxqa20ddf4iysda3-xdg-desktop-portal-hyprland-0.pre+date=2023-05-29_4d9ff0c/libexec/xdg-desktop-portal-hyprland &
sleep 4
/nix/store/yxxws6k59w5khkpqqpyvcl6pk65q0hzl-xdg-desktop-portal-1.16.0/libexec/xdg-desktop-portal &






