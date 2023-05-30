# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:
{
  # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix 
    ./vm.nix];


programs.bash.shellAliases = {
  switch = "sudo nixos-rebuild switch --flake .#nomad";
  switchu = "sudo nixos-rebuild switch --upgrade --flake .#nomad";
  clean = "sudo nix-collect-garbage -d";
  cleanold = "sudo nix-collect-garbage --delete-old";
  cleanboot = "sudo /run/current-system/bin/switch-to-configuration boot";
};

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


  #fonts
    fonts.fonts = with pkgs; [
      font-awesome
     (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
     ];
  #emojis
    #services.gollum.emoji = true;


#pci-passthroughnix

#      pciPassthrough = {
#    enable = true;
#    pciIDs = "10de:1ba1,10de:10f0";
#    cpuType = "intel";
#    libvirtUsers = [ "sager" ];[
#  };


#VFIOnix

#    specialisation."VFIO".configuration = {
#  system.nixos.tags = [ "with-vfio" ];
#  vfio.enable = true;
#};


#t.initrd.kernelModules = 
#  "vfio_pci"
#  "vfio"
#  "vfio_iommu_type1"
#  "vfio_virqfd"

#  "nvidia"
#  "nvidia_modeset"
#  "nvidia_uvm"
#  "nvidia_drm"
#];


  #Nix Virtualisation
  #virtualisation.spiceUSBRedirection.enable = true;
  #virtualisation.libvirtd.enable = true;
  #virtualisation.libvirtd.qemu.ovmf.enable = true;
  #virtualisation.libvirtd.qemu.swtpm.enable = true;
  #environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];





  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Define your hostname
  networking.hostName = "nixos";
  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;  

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  #Bluethooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

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
  

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Gnome login
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # displayManager.defaultSession = "hyprland";
  # displayManager.session = [
  #   {
  #    manage = "desktop";
  #     name = "none+Hyprland"
  #     start = ''exec $HOME/.xsession'';
  #     }
  #   ];   

  # Gnome environment
  #services.xserver.desktopManager.gnome.enable = true;
  
  #sddm
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.defaultSession = "hyprland";

  #Flatpak
  services.flatpak.enable = true;
  #locate
  services.locate.enable = true;

  # Enable Xwayland
  programs.xwayland.enable = true;             #enabled in flake
  programs.hyprland.enable = true;             #enabled in flake.nix
  programs.hyprland.nvidiaPatches = true;      #enabled in flake.nix

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Enable sound with pipewire.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    #wireplumber.enable= true;
  
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  
  #xdg
  
  xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
  ];

    wlr = {
    enable = true;
      };
    };

  environment.etc."xdg/user-dirs.defaults".text= ''
    DESKTOP=system/Desktop
    DOWNLOAD=system/Downloads
    TEMPLATES=system/Templates
    PUBLICSHARE=system/Public
    DOCUMENTS=system/Documents
    MUSIC=Media/music
    PICTURES=Media/photos
    VIDEOS=Media/video 
    '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nomad = {
    isNormalUser = true;
    description = "nomad";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" ];
    packages = with pkgs; [
     neovim
     google-chrome-beta
     swaylock-effects swayidle wlogout swaybg  #Login etc..  
     waybar                                    #topbar 
     wayland-protocols
     kanshi                                    #laptop dncies
     rofi mako rofimoji                        #home
     jellyfin-ffmpeg                           #video recorder
     viewnior                                  #image viewr
     pavucontrol                               #Volume control
     xfce.thunar                               #filemanager
     gnome-text-editor
     gnome.file-roller
     gnome.gnome-font-viewer
     gnome.gnome-calculator
     vlc
     amberol
     cava
     wl-clipboard
     wf-recorder
     sway-contrib.grimshot                 
     ffmpegthumbnailer                         #thumbnailer
     playerctl                                 #play,pause..
     pamixer                                   #mixer
     cava
     nordic
     papirus-icon-theme
     brightnessctl
     ####GTK Customization####
     gtk3
     glib
     xcur2png
     rubyPackages.glib2
     libcanberra-gtk3                          #notification sound
     #########################
     kitty
     libnotify
     poweralertd
     dbus
     polkit_gnome
     xdg-desktop-portal-hyprland
     ####photoshop dencies####
     gnome.zenity
     wine64Packages.waylandFull
     #########################
     curl
    ];
  };

#upower dbus
services.upower.enable = true;

#starship
programs.starship.enable = true;
#swaylock pass verify
security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

#thunar dencies
programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
];
services.gvfs.enable = true; 
services.tumbler.enable = true;

#gnome outside gnome
programs.dconf.enable = true;

#Steam

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};

 # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  #Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  
  #Cuda
  services.xmr-stak.cudaSupport = true;
  
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  
  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
 # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     vim
     zig
     wget
     killall
     git
     neofetch
     gh
     #OVMFFull
     #qemu
     #libvirt
     #kvmtool
     #bridge-utils
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
    #For Chromecast from chrome
    networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?


  #Overlays

  #Waybar wlr/Workspaces
    nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}


