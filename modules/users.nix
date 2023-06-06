{ config, pkgs, lib, inputs, ... }:
let
 user = "nomad";
in
{


# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" ];
    packages = with pkgs; [
     neovim
     google-chrome-beta
     swaylock-effects swayidle wlogout swaybg  #Login etc..  
     waybar                                    #topbar 
     wayland-protocols
     libsForQt5.qt5.qtwayland
     kanshi                                    #laptop dncies
     rofi mako rofimoji                        #Drawer + notifications
     jellyfin-ffmpeg                           #multimedia libs
     viewnior                                  #image viewr
     pavucontrol                               #Volume control
     xfce.thunar                               #filemanager
     xfce.xfconf
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
     #gsettings-desktop-schemas
     #wrapGAppsHook
     #xdg-desktop-portal-hyprland
     ####photoshop dencies####
     gnome.zenity
     wine64Packages.waylandFull
     curl
     #########################
    ];
  };

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
