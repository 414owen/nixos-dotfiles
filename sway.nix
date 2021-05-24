{ pkgs, config, ... }:

let
  modifier = "Mod4";
  common = import ./common.nix;
  wallpaper = common.wallpaper;
  term = "/usr/bin/alacritty";
  menu = ''
    ${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop \
      --usage-log=${config.xdg.cacheHome}/.j4_history \
      --dmenu="${pkgs.bemenu}/bin/bemenu --ignorecase --no-overlap" # [drvs]
  '';
  up = "k";
  down = "j";
  left = "h";
  right = "l";
  lock = "${pkgs.swaylock}/bin/swaylock";

  # Workspaces
  # output DP-2 (left)
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";

in

{
  wayland.windowManager.sway = {
    # systemdIntegration = true;
    wrapperFeatures = { gtk = true; };
    config = {

      defaultWorkspace = "workspace number 1";

      fonts = {
        names = [ "Jetbrains Mono" "FontAwesome" ];
        # style = "Bold Semi-Condensed";
        size = 11.0;
      };

      gaps = {
        inner = 5;
        outer = 5;
        smartGaps = true;
      };

      inherit modifier;

      input = {
        "*" = {
          xkb_layout = "gb";
          xkb_options = "ctrl:swapcaps";
        };
      };

      bars = [{
        command = "${pkgs.waybar}/bin/waybar";
      }];

      keybindings = {

        "Ctrl+Alt+l" = "exec ${lock} --clock --indicator -f -i ${wallpaper} --scaling fill";
        "${modifier}+Return" = "exec ${term}";
        "${modifier}+Space" = "exec ${menu}";
        "${modifier}+w" = "exec ${pkgs.brave}/bin/brave";
        "${modifier}+q" = "kill";

        # reload the configuration file
        "${modifier}+Shift+c" = "reload";

        # open file browser
        "${modifier}+f" = "exec ${pkgs.gnome3.nautilus}/bin/nautilus";

        # Moving around
        # Move your focus around
        "${modifier}+${up}" = "focus up";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${left}" = "focus left";
        "${modifier}+${right}" = "focus right";
        # or use $mod+[up|down|left|right]
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        # _move_ the focused window with the same, but add Shift
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${right}" = "move right";
        # ditto, with arrow keys
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        # Workspaces
        # switch to workspace
        "${modifier}+1" = "workspace ${ws1}";
        "${modifier}+2" = "workspace ${ws2}";
        "${modifier}+3" = "workspace ${ws3}";
        "${modifier}+4" = "workspace ${ws4}";
        "${modifier}+5" = "workspace ${ws5}";
        "${modifier}+6" = "workspace ${ws6}";
        "${modifier}+7" = "workspace ${ws7}";
        "${modifier}+8" = "workspace ${ws8}";
        "${modifier}+9" = "workspace ${ws9}";
        "${modifier}+0" = "workspace ${ws10}";

        # move focused container to workspace
        "${modifier}+Shift+1" = "move container to workspace ${ws1}";
        "${modifier}+Shift+2" = "move container to workspace ${ws2}";
        "${modifier}+Shift+3" = "move container to workspace ${ws3}";
        "${modifier}+Shift+4" = "move container to workspace ${ws4}";
        "${modifier}+Shift+5" = "move container to workspace ${ws5}";
        "${modifier}+Shift+6" = "move container to workspace ${ws6}";
        "${modifier}+Shift+7" = "move container to workspace ${ws7}";
        "${modifier}+Shift+8" = "move container to workspace ${ws8}";
        "${modifier}+Shift+9" = "move container to workspace ${ws9}";
        "${modifier}+Shift+0" = "move container to workspace ${ws10}";


        ## Audio control
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";

      };
    };
  };
}
