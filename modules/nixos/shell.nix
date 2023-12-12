{ config, pkgs, lib, inputs, ... }:
{

#shellAliases
  programs.bash.shellAliases = {
    switchhypr = "sudo nixos-rebuild switch --flake .#hyprland";
    switchuhypr = "sudo nixos-rebuild switch --upgrade --flake .#hyprland";
    switchgnome = "sudo nixos-rebuild switch --flake .#gnome";
    switchugnome = "sudo nixos-rebuild switch --upgrade --flake .#gnome";
    clean = "sudo nix-collect-garbage -d";
    cleanold = "sudo nix-collect-garbage --delete-old";
    cleanboot = "sudo /run/current-system/bin/switch-to-configuration boot";
};
#starship
  programs.starship.enable = true;
}
