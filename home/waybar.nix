{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./waybar.css;
    settings = [{
      modules-left = [
        "sway/workspaces"
      ];
      modules-center = [
        "clock"
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
      "cpu" = {
          "format" = " {usage}%";
          "tooltip" = false;
      };
      "clock" = {
        "interval" = 1;
        "format" = " {:%I:%M %p  %A %b %d}";
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-bluetooth" = "{icon} {volume}%";
        "format-muted" = "婢";
        "format-icons" = {
          "headphones" = "";
          "headset" = "";
          "default" = [ "" "" "" ];
        };
        "states" = {
          "warning" = 85;
        };
        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
      "network" = {
        # "interface" = "wlp2s0", // (Optional) To force the use of this interface
        "format-wifi" = "  &lt;{essid}&gt; {ipaddr}/{cidr}";
        "format-ethernet" = " {ipaddr}/{cidr}";
        "format-disconnected" = "⚠ Disconnected";
      };
      "memory" = {
        "format" = " {}%";
      };
      "backlight" = {
        "format" = "{icon} {percent}%";
        "format-icons" = [ "" "" ];
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
