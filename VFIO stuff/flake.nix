{
  description = "My Simple NixOS";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
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
          sager = lib.nixosSystem {
              inherit system;
              modules = [ ./configuration.nix 
              hyprland.nixosModules.default
              {programs.hyprland.enable = true;}
              ];
            };
          };
      };
  }

