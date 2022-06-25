{ pkgs, home, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
    };
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };
  home.pointerCursor = {
    name = "Qogir-dark";
    package = pkgs.qogir-theme;
  };
  fonts.fontconfig.enable = true;
}
