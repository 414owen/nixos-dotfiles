{ pkgs, ... }:

{
  programs.alacritty = {
    settings = {
      window = {
        decorations = "none";
        dynamic_title = true;
      };
      background_opacity = 0.9;
      live_config_reload = false;
    };
  };
}
