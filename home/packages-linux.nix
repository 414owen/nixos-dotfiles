{pkgs, ...}:

{
  home.packages = [
    pkgs.chromium
    pkgs.wl-clipboard
    pkgs.transmission_4-gtk
    pkgs.gimp
    pkgs.signal-desktop
    pkgs.inkscape
  ];
}
