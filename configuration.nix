{ config, pkgs, lib, inputs, modulesPath, ... }:

{


# Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix 
    ./modules/vm.nix
    ./modules/shell.nix
    ./modules/users.nix];



  # Fonts
    fonts.fonts = with pkgs; [
      font-awesome
     (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
     ];
  #emojis
    #services.gollum.emoji = true;


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";


  # Define your hostname
  networking.hostName = "nixos";
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
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

#Services
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
  #tlp
  services.tlp.enable = true;
  #upower dbus
  services.upower.enable = true;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
 };


#Display
  # Enable Gnome login
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  #services.xserver.displayManager.gdm.settings = {
  #};
 
  #xdg  
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
    ];

  #  wlr = {
  #   enable = true;
  #  };
  };

  environment.etc."xdg/user-dirs.defaults".text= ''
    DESKTOP=$HOME/Desktop
    DOWNLOAD=$HOME/Downloads
    TEMPLATES=$HOME/Templates
    PUBLICSHARE=$HOME/Public
    DOCUMENTS=$HOME/Documents
    MUSIC=$HOME/music
    PICTURES=$HOME/photos
    VIDEOS=$HOME/video 
    '';


#Nvidia
  #Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  services.xserver = {
    videoDrivers = [ "nvidia" ];

    config = ''
      Section "Device"
          Identifier  "Intel Graphics"
          Driver      "intel"
          #Option      "AccelMethod"  "sna" # default
          #Option      "AccelMethod"  "uxa" # fallback
          Option      "TearFree"        "true"
          Option      "SwapbuffersWait" "true"
          BusID       "PCI:0:2:0"
          #Option      "DRI" "2"             # DRI3 is now default
      EndSection

      Section "Device"
          Identifier "nvidia"
          Driver "nvidia"
          BusID "PCI:1:0:0"
          Option "AllowEmptyInitialConfiguration"
      EndSection
    '';
    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
    '';
  };

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.powerManagement.enable = true;
  # Cuda
  services.xmr-stak.cudaSupport = true; 
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
  #Switch GPU
  services.switcherooControl.enable = true;


  #hardware.nvidia.prime = {
    # Sync Mode
   # sync.enable = true;
    # Offload Mode
    #offload.enable = true;

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #  nvidiaBusId = "PCI:1:0:0";

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
  #  intelBusId = "PCI:0:2:0";
  #};


#SystemPackages
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
  ];


#Firewall
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
    #For Chromecast from chrome
    #networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}


