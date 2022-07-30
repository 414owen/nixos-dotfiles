{ ... }:

{
  programs.dircolors = {
    extraConfig = builtins.readFile "${(import ./nix/sources.nix).nord-dircolors}/src/dir_colors";
  };
}
