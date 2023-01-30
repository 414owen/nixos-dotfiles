{ pkgs, home, ... }:

{
  home.file.".config/yambar/config.yml" = {
    recursive = false;
    source = ./yambar.yml;
  };
}
