#!/usr/bin/env bash
wmctrl -r :ACTIVE: -b add,fullscreen
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"
echo -e " $YELLOW
 _   _  ___  __  __    _    ____    _   _ _____  _____  ____    ___ _   _ ____ _____  _    _     _     _____ ____  
| \ | |/ _ \|  \/  |  / \  |  _ \  | \ | |_ _\ \/ / _ \/ ___|  |_ _| \ | / ___|_   _|/ \  | |   | |   | ____|  _ \ 
|  \| | | | | |\/| | / _ \ | | | | |  \| || | \  / | | \___ \   | ||  \| \___ \ | | / _ \ | |   | |   |  _| | |_) |
| |\  | |_| | |  | |/ ___ \| |_| | | |\  || | /  \ |_| |___) |  | || |\  |___) || |/ ___ \| |___| |___| |___|  _ < 
|_| \_|\___/|_|  |_/_/   \_\____/  |_| \_|___/_/\_\___/|____/  |___|_| \_|____/ |_/_/   \_\_____|_____|_____|_| \_\

$ENDCOLOR
                                 $BLUE https://github.com/nomadics9 $ENDCOLOR
           $RED TO MAKE SURE EVERYTHING RUNS CORRECTLY $ENDCOLOR $GREEN RUN AS ROOT '"sudo bash install.sh"' $ENDCOLOR 
"
echo 
echo
echo -e "Type your desired $GREEN username $ENDCOLOR" 
read user
echo
cp /etc/nixos/hardware-configuration.nix ./hosts/hyprland
cp /etc/nixos/hardware-configuration.nix ./hosts/gnome
echo
echo -e "$GREEN Moments.... $ENDCOLOR"
sleep 1
cp -r .config ~/
echo -e "Your username is $GREEN "$user" $ENDCOLOR"
read -p " Are you sure? " -n 1 -r 
echo
echo -e "For $GREEN Hyprland type y $ENDCOLOR $YELLOW Gnome type n $ENDCOLOR"
read -p " (y)Hyprland (n)Gnome " -n 1 -r 
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo -e  "            👋 $GREEN $user on Hyprland $ENDCOLOR          "
sleep 2
  sed -i "s/user =.*/user = \"${user}\";/" ./flake.nix
  nixos-rebuild switch --flake .#hyprland
fi
if [[ $REPLY =~ ^[Nn]$ ]]
then
  echo -e  "            👋 $GREEN $user on Gnome $ENDCOLOR          "
sleep 2
  sed -i "s/user =.*/user = \"${user}\";/" ./flake.nix
  nixos-rebuild switch --flake .#gnome
fi


