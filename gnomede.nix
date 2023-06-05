{ config, pkgs, lib, inputs, ... }:
{


  #Gnome environment
   services.xserver.desktopManager.gnome.enable = true;
   environment.gnome.excludePackages = 
 (with pkgs; [
   gnome-photos
   gnome-tour
 ]) ++ (with pkgs.gnome; [
   cheese # webcam tool
   gnome-music
   gnome-terminal
   gedit # text editor
   epiphany # web browser
   geary # email reader
   evince # document viewer
   gnome-characters
   totem # video player
   tali # poker game
   iagno # go game
   hitori # sudoku game
   atomix # puzzle game
   rygel
   yelp
   gnome-logs
   gnome-clocks
   gnome-contacts
  
]);
 

#Choose Default Session 
  #services.xserver.displayManager.defaultSession = "hyprland";

}
 
