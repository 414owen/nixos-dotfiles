{ pkgs, ... }:

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
  xsession = {
    pointerCursor = {
      name = "Qogir-dark";
      package = pkgs.qogir-theme;
    };
  };
}
