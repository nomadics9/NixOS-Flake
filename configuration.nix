# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:
{
  # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix];

  #fonts
    fonts.fonts = with pkgs; [
      font-awesome
     (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
     ];



#vfio
#      pciPassthrough = {
#    enable = true;
#    pciIDs = "10de:1ba1,10de:10f0";
#    libvirtUsers = [ "sager" ];
#  };

#    specialisation."VFIO".configuration = {
#  system.nixos.tags = [ "with-vfio" ];
#  vfio.enable = true;
#};


#t.initrd.kernelModules = [
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
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.enable = true;
#boot.kernelModules = [ "kvm-intel" ];




  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Gnome environment
  #services.xserver.desktopManager.gnome.enable = true;
  
  #Flatpak
  services.flatpak.enable = true;

  # Enable Xwayland
  #programs.xwayland.enable = true;             #enabled in flake
  #programs.hyprland.enable = true;             #enabled in flake.nix
  #programs.hyprland.nvidiaPatches = true;      #enabled in flake.nix



  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sager = {
    isNormalUser = true;
    description = "sager";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" ];
    packages = with pkgs; [
     google-chrome
     discord
     swaylock-effects swayidle wlogout swaybg  #Login etc..  
     waybar                                    #topbar 
     wayland-protocols
     kanshi                                    #laptop dncies
     rofi dunst                                #home
     jellyfin-ffmpeg                           #video recorder
     viewnior                                  #image viewr
   	 pavucontrol                               #Volume control
   	 xfce.thunar #gnome.nautilus               #filemanager
     xfce.tumbler
     starship                                  #topbar dncies
   	 wl-clipboard
   	 wf-recorder
   	 sway-contrib.grimshot                 
   	 ffmpegthumbnailer                         #thumbnailer
   	 playerctl                                 #play,pause..
   	 pamixer                                   #mixer
   	 #blueman
     nordic
   	 papirus-icon-theme
   	 brightnessctl
     light
     brillo
     gtk3
     xcur2png
     rubyPackages.glib2
     kitty
     libnotify
     dbus
     polkit_gnome
     virtmanager
    ];
  };

#swaylock pass verify
security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
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
     neovim
     zig
     wget
     killall
     git
     neofetch
     gh
     #qemu
     #OVMF
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
  # networking.firewall.allowedUDPPorts = [ ... ];
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

  #Waybar Workspaces
    nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}


