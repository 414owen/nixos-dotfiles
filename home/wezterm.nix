{...}:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font_size = 12.0,
        window_decorations = "NONE",
        color_scheme = "owen",
        hide_tab_bar_if_only_one_tab = true,
        -- default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" },
      }
    '';


    colorSchemes = {
      owen = {
        ansi = [
           "#1d1f21"
           "#cc6666"
           "#b5bd68"
           "#f0c674"
           "#81a2be"
           "#b294bb"
           "#8abeb7"
           "#ffffff"
        ];
        background ="#1d1f21";
        brights = [
           "#333333"
           "#cc6666"
           "#b5bd68"
           "#f0c674"
           "#81a2be"
           "#b294bb"
           "#8abeb7"
           "#ffffff"
        ];
        cursor_bg ="#c5c8c6";
        cursor_border ="#c5c8c6";
        cursor_fg ="#1d1f21";
        foreground ="#c5c8c6";
        selection_bg ="#373b41";
        selection_fg ="#c5c8c6";
      };
    };
  };
}
