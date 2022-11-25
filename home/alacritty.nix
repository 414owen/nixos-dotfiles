{ pkgs, ... }:

let
  util = import ./util.nix { inherit pkgs; };
in

{
  programs.alacritty = {
    settings = {
      window = {
        decorations = "none";
        dynamic_title = true;
      };
      # background_opacity = 1;
      live_config_reload = false;
    };
  };
}
