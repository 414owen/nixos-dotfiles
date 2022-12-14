{...}:

{
  programs.waybar = {
    enable = true;
    settings = [{
      modules-left = [
        "sway/workspaces"
      ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "memory"
        "cpu"
        "network"
        "battery"
        "tray"
      ];
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = "婢 Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
        };
        "states" = {
          "warning" = 85;
        };
        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
      "battery" = {
        "bat" = "cw2015-battery";
        "adapter" = "cw2015-battery";
        "interval" = 10;
        "states" = {
          "warning" = 20;
          "critical" = 10;
        };
        "format" = "{icon} {capacity}%";
        "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        "format-full" = "{icon} {capacity}%";
        "format-charging" = " {capacity}%";
        "tooltip" = false;
      };
    }];
  };
}
