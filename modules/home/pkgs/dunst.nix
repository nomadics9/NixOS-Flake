{pkgs, ...}
{
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
    configFile = '' 
    [global]

    # --- Display --- #

    # The monitor to be displayed to
    monitor = 0

    # Follow monitor with mouse
    follow = mouse

    width = 300
    # height = 260
    origin = top-right
    offset = 10x1


    progress_bar = true
    progress_bar_height = 14
    progress_bar_frame_width = 1
    progress_bar_min_width = 150
    progress_bar_max_width = 300
    progress_bar_corner_radius = 5


    # Show how many messages are hidden
    indicate_hidden = yes

    # Shrink window if it's smaller than the width.
    shrink = no

    # The transparency of the window.
    transparency = 1

    # Draw a line between multiple notifications
    separator_height = 6

    separator_color = "#272f57"

    # Set notification padding
    padding = 16
    horizontal_padding = 16

    # Disable frame (border)
    frame_width = 0

    # Sort messages by urgency.
    sort = no

    # Disable idle time
    idle_threshold = 0

   
    # --- Text --- #

    # Set the font
    # font = "Noto Sans 11"
    font = "JetBrainsMono 11"

    # Set line height to font height
    line_height = 0

    # Reference for markup and formatting:
    #  <b>bold</b>
    #  <i>italic</i>
    #  <s>strikethrough</s>
    #  <u>underline</u>
    #  <https://developer.gnome.org/pango/stable/pango-Markup.html>.
    #  %a appname
    #  %s summary
    #  %b body
    #  %i iconname (including its path)
    #  %I iconname (without its path)
    #  %p progress value if set ([  0%] to [100%]) or nothing
    #  %n progress value if set without any extra characters
    #  %% Literal %

    markup = full
    format = "<b>%a</b>\n%b\n%s"

    # Left align the text
    alignment = left

    # Vertical alignment of message text and icon.
    vertical_alignment = center

    # Show age of message if message is old
    show_age_threshold = 120

    # Wrap text if it doesn't fit in geometry
    word_wrap = yes

    # Where to place ellipses if word wrap is disabled
    # ellipsize = middle

    # Use newlines '\n' in notifications.
    ignore_newline = no

    # Don't stack together notifications
    stack_duplicates = true

    # Hide the count of stacked notifications
    # hide_duplicate_count = false

    # Display indicators for URLs (U) and actions (A).
    show_indicators = yes

    
    # ---- Icons ---- #

    # Align icons left/right/off
    icon_position = left

    # Scale small icons up to this size, set to 0 to disable.
    min_icon_size = 50

    # Scale larger icons down to this size, set to 0 to disable
    max_icon_size = 60

    # Paths to default icons.
    icon_path = /usr/share/icons/kora/apps/scalable:/usr/share/icons/kora/status/scalable:/usr/share/icons/kora/actions/scalable:/usr/share/icons/kora/emblems/scalable:/usr/share/icons/kora/devices/scalable
 
    # --- History --- #

    # Avoid timing out hidden notifications
    sticky_history = yes

    # Maximum amount of notifications kept in history
    history_length = 100


    # --- Misc/Advanced --- #

    dmenu = /usr/bin/dmenu -p dunst:

    # Browser for opening urls in context menu.
    browser = google-chrome-stable -new-tab

    # Always run rule-defined scripts, even if the notification is suppressed
    always_run_script = false

    # Define the title of the windows spawned by dunst
    title = Dunst

    # Define the class of the windows spawned by dunst
    class = Dunst

    # Define the corner radius of the notification window
    corner_radius = 20

    # Don't gnore the dbus closeNotification message.
    ignore_dbusclose = false


    # --- Legacy --- #

    # Use the Xinerama extension instead of RandR for multi-monitor support.
    force_xinerama = false


    # --- Mouse --- #
    mouse_left_click = close_current
    mouse_middle_click = close_all, close_current
    mouse_right_click = do_action


[experimental]
    per_monitor_dpi = false

[urgency_low]
    background = "#141929fe"
    highlight = "#6fa6e7"
    frame_color = "#272f57"
    foreground = "#dae1f2"
    timeout = 8

[urgency_normal]
    background = "#26292e"
    highlight = "#5ca1ff"

    frame_color = "#272f57"
    foreground = "#dae1f2"
    timeout = 8

[urgency_critical]
    background = "#5ca1ffff"
    highlight = "#fe6c5a"
    foreground = "#1c2138"
    frame_color = "#52426e"
    timeout = 0
    icon = battery-ac-adapter

[backlight]
    appname = "Backlight"
    highlight = "#fc7b80"

[music]
    appname = "Music"

[volume]
    summary = "Volume*"
    highlight = "#cb8cf4"

[battery]
  

'';
}
