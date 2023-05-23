# NixOS-Flake
My NixOS Flake + dotfiles

NixOS with personal packages running on HyprlandWM + Waybar


![ScreenShot](https://i.ibb.co/zZbTRPp/2023-05-22-T23-05-36-798602415-03-00.png)

![ScreenShot](https://i.ibb.co/FHh8QZM/2023-05-22-T23-05-59-807197950-03-00.png)

![ScreenShot](https://i.ibb.co/M9gs7n5/2023-05-22-T23-07-35-808155981-03-00.png)

<div align="center">
  <a href="https://www.youtube.com/watch?v=PjE-PTNWwqs"><img src="https://img.youtube.com/vi/PjE-PTNWwqs/0.jpg" alt="Overview"></a>
</div>


Usage:

1. clone
   > gh repo clone nomadics9/NixOS-Flake
2. cd to cloned dir 
3. overwrite your ./hardware-configuration.nix from /etc/nixos/hardware-configuration.nix
   > sudo cp ~/etc/nixos/hardware-configuration.nix .
4. update and switch or boot the flake
   > nix flake update
    - switch or boot
   > sudo nixos-rebuild switch --flake .#sager <---- change username in configuration.nix and flake.nix 
5. copy .config to ~/.config
   > cp -r .config ~/.config

Extras:
For GTK theming 
nwg-look is required. not in nix repo.

Will upload my nwg-look built pkg here later.

Enjoy~
