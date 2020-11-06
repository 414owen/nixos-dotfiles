# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
  wallpaper = builtins.fetchurl {
    url = "https://gitlab.gnome.org/GNOME/gnome-backgrounds/-/raw/9e708b405ef76b188ac6195ef2dc04ecc314312e/backgrounds/LightWaves.png";
    sha256 = "1xrqwm3cdngkdjpprl83pckb6s5w4vqcykhpammkv5m3ycjhbrpr";
  };
  wallpaper-uri = "file://${wallpaper}";
in
{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      "picture-options" = "zoom";
      "picture-uri" = wallpaper-uri;
      "primary-color" = "#ffffff";
      "secondary-color" = "#000000";
    };

    "org/gnome/desktop/interface" = {
      "cursor-theme" = "Paper";
      "gtk-im-module" = "gtk-im-context-simple";
      "gtk-theme" = "Adwaita-dark";
      "icon-theme" = "Paper-Mono-Dark";
    };

    "org/gnome/desktop/input-sources" = {
      "sources" = [ (mkTuple [ "xkb" "gb" ]) ];
      "xkb-options" = [ "ctrl:swapcaps" ];
    };

    "org/gnome/mutter" = {
      "attach-modal-dialogs" = true;
      "dynamic-workspaces" = true;
      "edge-tiling" = true;
      "focus-change-on-pointer-rest" = true;
      "workspaces-only-on-primary" = true;
    };

    # "org/gnome/desktop/peripherals/touchpad" = {
    #   "disable-while-typing" = false;
    #   "two-finger-scrolling-enabled" = true;
    # };

    "org/gnome/nautilus/preferences" = {
      "default-folder-viewer" = "icon-view";
      "search-filter-time-type" = "last_modified";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      "calculator" = [ "<Super>c" ];
      "custom-keybindings" = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      "email" = [ "<Super>e" ];
      "home" = [ "<Super>f" ];
      "www" = [ "<Super>w" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      "binding" = "<Super>t";
      "command" = "st -n st";
      "name" = "Launch Terminal";
    };

    # "org/gnome/settings-daemon/plugins/power" = {
    #   "sleep-inactive-ac-type" = "nothing";
    # };

    "org/gnome/settings-daemon/plugins/xsettings" = {
      "antialiasing" = "rgba";
      "hinting" = "full";
    };

    "org/gnome/system/location" = {
      "enabled" = true;
    };
  };
}
