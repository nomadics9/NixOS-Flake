{
  description = "Hyprland+waybar";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    hyprland.url = "github:hyprwm/Hyprland";
   };


  outputs = { self, nixpkgs, hyprland, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
       inherit system;
       config.allowUnfree = true;
        };
        lib = nixpkgs.lib;
    in {
        nixosConfigurations = {
          nomad = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [ ./configuration.nix 
              hyprland.nixosModules.default
              {programs.hyprland.enable = true;
              programs.hyprland.nvidiaPatches=true;
              programs.hyprland.xwayland.enable=true;}];
            };
          };
      };
  }

#nixos-22.11




