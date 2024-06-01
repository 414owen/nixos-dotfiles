{pkgs, ...}:

{
  home.packages = [
    pkgs.wl-clipboard
    pkgs.transmission-gtk
    pkgs.gimp
    pkgs.signal-desktop
    pkgs.inkscape
  ];
}
