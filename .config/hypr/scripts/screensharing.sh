#!/usr/bin/env bash
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
/nix/store/fgw6w4r8wq6jwr4ikgwby6gfmdfyn2gi-xdg-desktop-portal-hyprland-1.2.3+date=2023-10-22_22e7a65/libexec/xdg-desktop-portal-hyprland-1.2.3+date=2023-10-22_22e7a65/libexec/xdg-desktop-portal-hyprland &
sleep 2
/nix/store/vcvfsslah74q4850nhx10qd3i93pl23h-xdg-desktop-portal-1.16.0/libexec/xdg-desktop-portal&
