{ pkgs, ... }:

{
  programs.foot = {
    server.enable = true;
    settings = {
      main = {
        # term = "xterm-256color";
        font = "Fira Code:size=9";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      csd = {
        preferred = "none";
      };

      # catppuccin frappe theme 0.2
      # cursor.color = "1A1826 D9E0EE";
      # colors = {
      #   "foreground" = "c6d0f5"; # Text
      #   "background" = "303446"; # Base
      #   "regular0" = "51576d";   # Surface 1
      #   "regular1" = "e78284";   # red
      #   "regular2" = "a6d189";   # green
      #   "regular3" = "e5c890";   # yellow
      #   "regular4" = "8caaee";   # blue
      #   "regular5" = "f4b8e4";   # pink
      #   "regular6" = "81c8be";   # teal
      #   "regular7" = "b5bfe2";   # Subtext 1
      #   "bright0" = "626880";    # Surface 2
      #   "bright1" = "e78284";    # red
      #   "bright2" = "a6d189";    # green
      #   "bright3" = "e5c890";    # yellow
      #   "bright4" = "8caaee";    # blue
      #   "bright5" = "f4b8e4";    # pink
      #   "bright6" = "81c8be";    # teal
      #   "bright7" = "a5adce";    # Subtext 0
      # };

      # catppuccin mocha theme 0.2
      # cursor.color = "1A1826 D9E0EE";
      # colors = {
      #   "foreground" = "cdd6f4"; # Text
      #   "background" = "1e1e2e"; # Base
      #   "regular0" = "45475a";   # Surface 1
      #   "regular1" = "f38ba8";   # red
      #   "regular2" = "a6e3a1";   # green
      #   "regular3" = "f9e2af";   # yellow
      #   "regular4" = "89b4fa";   # blue
      #   "regular5" = "f5c2e7";   # pink
      #   "regular6" = "94e2d5";   # teal
      #   "regular7" = "bac2de";   # Subtext 1
      #   "bright0" = "585b70";    # Surface 2
      #   "bright1" = "f38ba8";    # red
      #   "bright2" = "a6e3a1";    # green
      #   "bright3" = "f9e2af";    # yellow
      #   "bright4" = "89b4fa";    # blue
      #   "bright5" = "f5c2e7";    # pink
      #   "bright6" = "94e2d5";    # teal
      #   "bright7" = "a6adc8";    # Subtext 0
      # };

      
      # rose-pine theme
      colors = {
        "background" = "191724"; 
        "foreground" = "e0def4"; 
        "regular0" = "26233a";  # black
        "regular1" = "eb6f92";  # red
        "regular2" = "31748f";  # green
        "regular3" = "f6c177";  # yellow
        "regular4" = "9ccfd8";  # blue
        "regular5" = "c4a7e7";  # magenta
        "regular6" = "ebbcba";  # cyan
        "regular7" = "e0def4";  # white

        "bright0" = "6e6a86";   # bright black
        "bright1" = "eb6f92";   # bright red
        "bright2" = "31748f";   # bright green
        "bright3" = "f6c177";   # bright yellow
        "bright4" = "9ccfd8";   # bright blue
        "bright5" = "c4a7e7";   # bright magenta
        "bright6" = "ebbcba";   # bright cyan
        "bright7" = "e0def4";   # bright white
      };
    };
  };
}
