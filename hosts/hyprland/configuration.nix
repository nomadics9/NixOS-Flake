{ config, pkgs, lib, inputs, modulesPath, ... }:

{
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix
                ./../../modules/nixos/battery.nix
               # ./../../modules/nixos/shell.nix
                ./../../modules/nixos/users.nix
                ./../../modules/nixos/nvidia.nix
    ];
  
  # TEMP
    xdg.portal.config.common.default = "*";

  # fix
    #boot.kernelParams = [ "intel_pstate=active" ];
  
  # Nix
    nix.optimise.automatic = true;
    nixpkgs.config.allowUnfree = true;
    nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

 

  # ntfs support
    boot.supportedFilesystems = [ "ntfs" ];

  # Fonts
    fonts.packages = with pkgs; [
      font-awesome
      noto-fonts-emoji
     (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka"  ]; })
     ];
  # emojis
    services.gollum.emoji = true;


  ###Bootloader###
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
  #Boot entries limit
    boot.loader.systemd-boot.configurationLimit = 3;


  ###Network###
  #Define your hostname
    networking.hostName = "unkown";
  # Enable networking
    networking.networkmanager.enable = true; 
  # Bluethooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    #isDefault
    #wireplumber.enable= true;
  
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  ###TimeZone and Input###
  # Set your time zone.
    time.timeZone = "Asia/Kuwait";
  # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
 
    services.xserver = {
        exportConfiguration = true; # link /usr/share/X11/ properly
        layout = "us,ara";
        xkbOptions = "grp:alt_shift_toggle";
        xkbVariant = "qwerty_digits";
    };

  ###Services###
  # Enable the X11 windowing system.
    services.xserver.enable = true;
  # Flatpak
    services.flatpak.enable = true;
  # locate
    services.locate.enable = true;
  # Enable CUPS to print documents.
    services.printing.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;
    services.xserver.libinput.touchpad.tapping = true; #tap

  #polkit Auth Agent
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

  
  ###Display###
  # Enable Gnome login
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    #services.xserver.displayManager.gdm.settings = {};
   
  #xdg  
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = false;
      #gtkUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        #xdg-desktop-portal-hyprland
        #xdg-desktop-portal-wlr
      ];
      wlr.enable = true;
    };


  ###SystemPackages###
  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     vim
     zig
     wget
     killall
     neofetch
     git
     gh
    ];

  #Firewall
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
    #For Chromecast from chrome
    #networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ];
  # Or disable the firewall altogether.
   #networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}


