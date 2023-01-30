{ pkgs, ... }:

let
  util = import ./util.nix { inherit pkgs; };
in

{
  programs.alacritty = {
    enable = false;
    settings = {
      font = {
        normal = {
          family = "Roboto Mono Nerd Font";
          style = "Regular";
        };
      };
      window = {
        decorations = "none";
        dynamic_title = true;
      };
      # background_opacity = 1;
      live_config_reload = false;
    };
  };
}
