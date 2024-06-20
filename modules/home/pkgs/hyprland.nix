{...}:
{
wayland.windowManager.hyprland.enable = true;
wayland.windowManager.hyprland.extraConfig = 
''
########################################################################################

 ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ ███████╗
██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ ██╔════╝
██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗███████╗
██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║╚════██║
╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝███████║
 ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝       

#########################################################################################

debug {
    suppress_errors = true
}

# You have to change this based on your monitor
monitor=eDP-1,2560x1600@119.93,0x0,1.25
#monitor=DP-1,4096x2160@60.0,0x0,1,mirror,eDP-1
#monitor=eDP-1,auto,1
# Status bar :) 
exec-once=waybar
exec-once = wl-clipboard-history -t
# Notification 
exec-once = poweralertd
exec-once = syncthing
exec-once = sleep 4; qsyncthingtray
# Wallpaper
exec-once= bash ~/.config/waybar/scripts/changewallpaper.sh
# Cursor
exec-once= hyprctl setcursor Bibata-Modern-Classic 24
# Bluetooth
exec-once=blueman-applet # Make sure you have installed blueman + blueman-utils

exec-once = dbus-update-actvation-environment --systemd --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP 
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS

# Screen Sharing
exec-once = ~/.config/hypr/scripts/screensharing.sh


input {
  # Remap Capslock -> Esc for Vim users  
  #kb_options=caps:escape
  #repeat_rate=50
  #repeat_delay=240
  
  kb_layout=us,ara
  kb_options=grp:alt_shift_toggle


  touchpad {
    disable_while_typing=1
    natural_scroll=1
    clickfinger_behavior=1
    middle_button_emulation=0
    tap-to-click=1
    sensitivity=1
  }
}


gestures { 
  workspace_swipe=true 
  workspace_swipe_min_speed_to_force=5
}

general {
    layout=dwindle
    sensitivity=1.0 # for mouse cursor

    gaps_in=1   #7
    gaps_out=0  #2
    border_size=2
    col.active_border=0x66333333
    col.inactive_border=0x66333333

    apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
}

decoration {
    rounding=19
    blur {
    enabled = true
    size=13  # minimum 1
    passes=3  # minimum 1, more passes = more resource intensive.
    new_optimizations = true 
	}  
    # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
    # if you want heavy blur, you need to up the blur_passes.
    # the more passes, the more you can up the blur_size without noticing artifacts.
    drop_shadow=true
    shadow_range=25
    col.shadow=rgb(252626)           #0xffa7caff #86AAEC
    col.shadow_inactive=0x50000000
}

# Blur for waybar 
blurls=waybar

animations {
    enabled=1
    bezier=overshot,0.13,0.99,0.29,1.1
    animation=windows,1,4,overshot,slide
    animation=fadeIn,1,10,default
    animation=workspaces,1,8.8,overshot,slide
    animation=border,1,14,default
    #animation=windows,1,8,default,popin 80%
}

dwindle {
    pseudotile=1 # enable pseudotiling on dwindle
    force_split=0animation=windows,1,8,default,popin 80%
    no_gaps_when_only = true
}

master {
  new_on_top=true
  no_gaps_when_only = true
}

misc {
  disable_hyprland_logo=true
  disable_splash_rendering=true
  mouse_move_enables_dpms=true
  vfr = true
  hide_cursor_on_touch = true
}

########################################################################################
██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗███████╗    ██████╗ ██╗   ██╗██╗     ███████╗███████╗
██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║██╔════╝    ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║███████╗    ██████╔╝██║   ██║██║     █████╗  ███████╗
██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║╚════██║    ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝███████║    ██║  ██║╚██████╔╝███████╗███████╗███████║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝
########################################################################################


# Float Necessary Windows
windowrule=animation,1,4,overshot,slide,^(rofi)$
windowrule=float,Rofi
windowrule=float,pavucontrol
windowrule=float,Calculator

windowrule=size 200,200,title:^(float_kitty)$
windowrule=float,title:^(full_kitty)$
windowrule=tile,title:^(kitty)$
windowrule=float,title:^(fly_is_kitty)$



windowrulev2 = float,class:^(google-chrome-beta)$,title:^(Save File)$
windowrulev2 = float,class:^(google-chrome-beta)$,title:^(Open File)$
windowrulev2 = float,class:^(google-chrome-beta)$,title:^(Picture-in-Picture)$
windowrulev2 = float,class:^(blueman-manager)$
windowrulev2 = float,class:^(org.twosheds.iwgtk)$
windowrulev2 = float,class:^(blueberry.py)$
windowrulev2 = float,class:^(xdg-desktop-portal-gtk)$
windowrulev2 = float,class:^(geeqie)$
windowrulev2 = tile,class:^(neovide)$

# Increase the opacity 
windowrule=opacity 0.96,thunar
windowrule=opacity 0.96,discord
windowrule=opacity 0.9,VSCode
windowrule=opacity 0.96,obsidian
windowrule=opacity 0.7,neovide

#w
windowrule=opacity 1,neovim
bindm=SUPER,mouse:272,movewindow
bindm=SUPER,mouse:273,resizewindow

#xwayland bridge
windowrulev2 = opacity 0.0 override 0.0 override,class:^(org.kde.xwaylandvideobridge)$
windowrulev2 = noanim,class:^(xwaylandvideobridge)$
windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

###########################################

██╗  ██╗███████╗██╗   ██╗    ██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
██║ ██╔╝██╔════╝╚██╗ ██╔╝    ██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
█████╔╝ █████╗   ╚████╔╝     ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
██╔═██╗ ██╔══╝    ╚██╔╝      ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
██║  ██╗███████╗   ██║       ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
╚═╝  ╚═╝╚══════╝   ╚═╝       ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
###########################################
# example binds
bind = SUPER, F1, exec, ~/.config/hypr/keybind
bind = SUPER, Q, killactive
bind = SUPER, B, exec,firefox
bind = SUPER, F, fullscreen,1
bind = SUPERSHIFT, F, fullscreen,0
bind = SUPER, V, togglesplit, # dwindle

bind = SUPER, j, movefocus, d
bind = SUPER, k, movefocus, u

bind = SUPER, h, movefocus, l
bind = SUPER, l, movefocus, r

binde = SUPER, left, resizeactive,-40 0
binde = SUPER, right, resizeactive,40 0

binde = SUPER, up, resizeactive,0 -40
binde = SUPER, down, resizeactive,0 40

bind = SUPERSHIFT, h, movewindow,l
bind = SUPERSHIFT, l, movewindow,r
bind = SUPERSHIFT, k, movewindow,u
bind = SUPERSHIFT, j, movewindow,d

bind= SUPERSHIFT, t, exec,kitty --start-as=fullscreen -o 'font_size=18' --title all_is_kitty
bind= ALT,RETURN, exec, kitty --title fly_is_kitty
bind= SUPER,RETURN, exec, kitty --title kitty_term

bind = SUPER, C, killactive,
bind = SUPERSHIFT, Q, exit,
bind = SUPER, E, exec, nautilus
bind = SUPER, R, exec, rofi -show drun -show-icons
bind = SUPER, P, pseudo,
bind = SUPER, ESCAPE, exec, wlogout
bind = SUPER, SPACE, exec, swaylock

bind=,XF86AudioMute,exec,~/.config/hypr/scripts/volume mute
binde=,XF86AudioLowerVolume,exec,~/.config/hypr/scripts/volume down
binde=,XF86AudioRaiseVolume,exec,~/.config/hypr/scripts/volume up
bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle

bindle=,XF86MonBrightnessUp,exec,~/.config/hypr/scripts/brightness up  # increase screen brightness
bindle=,XF86MonBrightnessDown,exec,~/.config/hypr/scripts/brightness down # decrease screen brightnes
bind=SUPERSHIFT,C,exec,bash ~/.config/hypr/scripts/hyprPicker.sh
bind = ALTCTRL, DELETE, exec, htop
bind = SUPER, T, togglefloating,

# Screen shot
$screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimshot --notify copy active; hyprctl keyword animation "fadeOut,1,4,default"
bind = SUPER, S, exec, $screenshotarea
#bind = SUPERSHIFT, S ,exec, grimshot --notify copy area
bind=SUPERSHIFT,S,exec, grimshot savecopy area - | swappy -f -
# Screen recorder
bind = SUPERSHIFT, R, exec,wf-recorder & dunstify -a Recordering Started -i -u -A "^C ,stop" -t 0 -i ~/icons/rec-button.png 
# Emoji selector 
bind = SHIFTSUPER, E, exec, rofimoji
#bind = SHIFTSUPER, E, exec, rofi -modi emoji -show emoji --keybinding-copy ctrl+c
# change HZ
bind = SUPER, A, exec, ~/.config/hypr/scripts/screenHz.sh 

bind = SUPERSHIFT, RETURN, layoutmsg, swapwithmaster


bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
bind = SUPER, 0, workspace, 10

bind=SUPERSHIFT,1,movetoworkspacesilent,1
bind=SUPERSHIFT,2,movetoworkspacesilent,2
bind=SUPERSHIFT,3,movetoworkspacesilent,3
bind=SUPERSHIFT,4,movetoworkspacesilent,4
bind=SUPERSHIFT,5,movetoworkspacesilent,5
bind=SUPERSHIFT,6,movetoworkspacesilent,6
bind=SUPERSHIFT,7,movetoworkspacesilent,7
bind=SUPERSHIFT,8,movetoworkspacesilent,8
bind=SUPERSHIFT,9,movetoworkspacesilent,9
bind=SUPERSHIFT,0,movetoworkspacesilent,10

bind = ALT, Tab, cyclenext

# unscale XWayland
xwayland {
  force_zero_scaling = true
}

# toolkit-specific scale
env = GDK_SCALE,1.25
env = XCURSOR_SIZE,25
'';
}
