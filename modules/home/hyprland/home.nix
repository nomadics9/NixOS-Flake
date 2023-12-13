{ config, pkgs, user, home-manager, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";

in
{
  programs.zsh = {
  enable = true;
  shellAliases = {
    switchhypr = "sudo nixos-rebuild switch --flake .#hyprland";
    switchuhypr = "sudo nixos-rebuild switch --upgrade --flake .#hyprland";
    switchgnome = "sudo nixos-rebuild switch --flake .#gnome";
    switchugnome = "sudo nixos-rebuild switch --upgrade --flake .#gnome";
    clean = "sudo nix-collect-garbage -d";
    cleanold = "sudo nix-collect-garbage --delete-old";
    cleanboot = "sudo /run/current-system/bin/switch-to-configuration boot";
    };
    enableAutosuggestions = true;
     zplug = {
     enable = true;
     plugins = [
       { name = "zsh-users/zsh-autosuggestions"; }
       ];
    };
  };

  #starship
    programs.starship = {
    enable = true;
    enableZshIntegration = true;
    };

  # Allow "unfree" licenced packages
  nixpkgs.config = { allowUnfree = true; };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  programs.home-manager.enable = true;
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";
  #Gtk 
    gtk = {
      enable = true;
      font.name = "TeX Gyre Adventor 10";
      theme = {
        name = "Juno";
        package = pkgs.juno-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      #gtk3.extraConfig = { 
      #Settings = ''
      #  gtk-application-prefer-dark-theme=1
      #'';
      #};
    

      #gtk4.extraConfig = {
      #Settings = ''
      #  gtk-application-prefer-dark-theme=1
      #'';
    #};
    
  };
  #gnome outside gnome
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
	theme = "Juno";
      };
    };
  };

  #rofi
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    plugins = [pkgs.rofi-emoji];
    configPath = ".config/rofi/config.rasi";
    theme = "nord-oneline.rasi"; 
  };

  #thunar
    # programs.thunar = {
    #   package = pkgs.xfce.thunar;
    #   enable = true;
    #   plugins = with pkgs.xfce; [
    #   thunar-archive-plugin
    #   thunar-volman
    #   xfconf
    # ];
    # };
    
  home.packages = with pkgs; [
     neovim
     firefox-wayland
     swaylock-effects swayidle wlogout swaybg  #Login etc..  
     waybar                                    #topbar 
     hyprland-protocols
     libsForQt5.qt5.qtwayland
     #rofi-wayland rofi-emoji
     dunst				       #notifications
     jellyfin-ffmpeg                           #multimedia libs
     viewnior                                  #image viewr
     pavucontrol                               #Volume control
     #xfce.thunar                               #filemanager
     #xfce.xfconf
     gnome-text-editor
     gnome.file-roller
     gnome.gnome-font-viewer
     gnome.gnome-calculator
     vlc                                       #Video player
     amberol                                   #Music player
     cava                                      #Sound Visualized
     wl-clipboard                              
     wf-recorder                               #Video recorder
     sway-contrib.grimshot                     #Screenshot
     ffmpegthumbnailer                         #thumbnailer
     playerctl                                 #play,pause..
     pamixer                                   #mixer
     brightnessctl                             #Brightness control
     ####GTK Customization####
     nordic
     papirus-icon-theme
     gtk3
     glib
     xcur2png
     rubyPackages.glib2
     libcanberra-gtk3                          #notification sound
     #########System#########
     kitty
     gnome.gnome-system-monitor
     libnotify
     poweralertd
     dbus
     wrapGAppsHook
     cudatoolkit
     ###apps###
     discord
  ];

  #Session variables
     home.sessionVariables = {
	     BROWSER = "firefox";
	     EDITOR = "neovim";
	     TERMINAL = "kitty";
	     NIXOS_OZONE_WL = "1";
	     QT_QPA_PLATFORMTHEME = "gtk3";
	     QT_SCALE_FACTOR = "1";
	     MOZ_ENABLE_WAYLAND = "1";
	     SDL_VIDEODRIVER = "wayland";
	     _JAVA_AWT_WM_NONREPARENTING = "1";
	     QT_QPA_PLATFORM = "wayland-egl";
	     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
	     QT_AUTO_SCREEN_SCALE_FACTOR = "1";
	     WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
	     #WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line  
	     GBM_BACKEND = "nvidia-drm";
	     CLUTTER_BACKEND = "wayland";
	     __GLX_VENDOR_LIBRARY_NAME = "nvidia";
	     LIBVA_DRIVER_NAME = "nvidia";
	     WLR_RENDERER = "vulkan";
	     #__NV_PRIME_RENDER_OFFLOAD="1"; 
	     XDG_CURRENT_DESKTOP = "Hyprland";
	     XDG_SESSION_DESKTOP = "Hyprland";
	     XDG_SESSION_TYPE = "wayland";
	     GTK_USE_PORTAL = "1";
	     #NIXOS_XDG_OPEN_USE_PORTAL = "1";
	     XDG_CACHE_HOME = "\${HOME}/.cache";
	     XDG_CONFIG_HOME = "\${HOME}/.config";
	     #XDG_BIN_HOME = "\${HOME}/.local/bin";
	     XDG_DATA_HOME = "\${HOME}/.local/share";

    };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  #home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;

}
