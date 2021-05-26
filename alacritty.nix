{ pkgs, ... }:

let
  util = import ./util.nix { inherit pkgs; };
  theme = util.fromYAML (builtins.readFile "${(import ./nix/sources.nix).nord-alacritty}/src/nord.yml");
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
    } // theme;
  };
}
