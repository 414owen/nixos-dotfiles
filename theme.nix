{ pkgs, ... }:

{
  gtk = {
    iconTheme = {
      package = pkgs.numix-icon-theme-circle;
      name = "Numix Circle";
    };
    theme = {
      name = "Adwaita-dark";
    };
    gtk3 = {
      bookmarks = [
        "~/src"
      ];
    };
  };
}
