{ pkgs, ... }:

{
  # Wayland-based status bar.
  programs.waybar = {
    enable = true;
  };
}
