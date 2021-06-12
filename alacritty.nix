{ pkgs, ... }:

let
  famObj = { family = "Fira Mono"; };
in

{
  programs.alacritty = {
    settings = {
      window = {
        decorations = "none";
        dynamic_title = true;
      };
      background_opacity = 0.9;
      live_config_reload = false;
      font = {
        normal = famObj;
        bold = famObj;
        italic = famObj;
        bold_italic = famObj;
        size = 14;
      };
    };
  };
}
