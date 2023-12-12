{
  description = "Hyprland+waybar";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";   
    };


  outputs = { self, nixpkgs, hyprland, home-manager, ... }: 
    let
      user = "nomad";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
       inherit system;
       config.allowUnfree = true;
        };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        hyprland = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit user;};
          modules = [ ./hosts/hyprland/configuration.nix
              
            hyprland.nixosModules.default
            {
              programs.hyprland.enable = true;
              #programs.hyprland.enableNvidiaPatches=true; #no longer needed
              programs.hyprland.xwayland.enable=true;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit user;};
              home-manager.users.${user} = import ./modules/home/home.nix;
            }
          ];
        };
        gnome = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit user;};
          modules = [ ./hosts/gnome/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit user;};
              home-manager.users.${user} = import ./modules/home/home.nix;
            }
          ];
      };

      };

    };
}


#nixos-22.11





