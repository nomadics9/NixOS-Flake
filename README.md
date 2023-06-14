# NixOS-Flake
My NixOS Flake + dotfiles

NixOS with personal packages running on HyprlandWM + Waybar


![ScreenShot](https://i.ibb.co/26rqbc2/Untitled.png)

![ScreenShot](https://i.ibb.co/FHh8QZM/2023-05-22-T23-05-59-807197950-03-00.png)

![ScreenShot](https://i.ibb.co/fDZ2hSk/Untitled1.png)

Added some more features in waybar
![ScreenShot](https://i.ibb.co/6HRpPHX/screenshot.jpg)

[____________________![waybar hyprland](https://i.ibb.co/Wyz0765/youtube.png)](https://www.youtube.com/watch?v=PjE-PTNWwqs)____________________



<b>Usage:</b><br>
First Install NixOS with any GUI you like to proceed from there<br>
    👣Gnome NixOS<br>
    🔗https://channels.nixos.org/nixos-23.05/latest-nixos-gnome-x86_64-linux.iso
<br>

INSTALLER:
<br>
1. clone
    > gh repo clone nomadics9/NixOS-Flake
2. cd to cloned dir
3. follow the installer
    > sudo bash install.sh

MANUAL:
<br> 
1. clone
    > gh repo clone nomadics9/NixOS-Flake
2. cd to cloned dir 
3. overwrite your ./hardware-configuration.nix from /etc/nixos/hardware-configuration.nix
    > sudo cp ~/etc/nixos/hardware-configuration.nix .
4. change username to your user in <b>flake.nix</b>
    > ![ScreenShot](https://i.ibb.co/wsgSdcZ/2023-06-06-T23-01-40-950960816-03-00.png)
5. update and switch or boot the flake
    > nix flake update
    - switch or boot
    > sudo nixos-rebuild switch --flake .#YOURUSERNAME
6. copy .config to ~/
    > cp -r .config ~/

Extras:
For GTK theming:<br>
<s>nwg-look is required. not in nix repo.
Will upload my nwg-look built pkg here later.</s><br>

<b>NO NEED FOR NWG ANYMORE ALL THROUGH HOME MANAGER</b> 🙋<br>

for wallpapers to work place all wallpapers in <b>~/Desktop/wallpapers</b>



todo:
dotfiles in homemanager aswell<br>
<s>script to install </s><br>


SUPER + F1 for all keybinds!<br>

Enjoy~

