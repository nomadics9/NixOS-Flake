{ config, pkgs, lib, inputs, user, ... }:
{


# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
 };
  # #swaylock pass verify
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  #
  # #thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
    xfconf
  ];
  };
  services.gvfs.enable = true; 
  services.tumbler.enable = true;

  #gnome outside gnome
  #programs.dconf.enable = lib.mkDefault true;

  # #Steam
   programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
   };
  
  #DIRS
    environment.etc."xdg/user-dirs.defaults".text= ''
    DESKTOP=$HOME/Desktop
    DOWNLOAD=$HOME/Downloads
    TEMPLATES=$HOME/Templates
    PUBLICSHARE=$HOME/Public
    DOCUMENTS=$HOME/Documents
    MUSIC=$HOME/Music
    PICTURES=$HOME/Photos
    VIDEOS=$HOME/Video 
    '';


   #Overlays
    #Waybar wlr/Workspaces
    #nixpkgs.overlays = [
    #(self: super: {
    #  waybar = super.waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-experimental=true" ];
    #  });
    #})
    #];


 
}

