# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
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
      # "cursor-theme" = "Paper";
      "gtk-im-module" = "gtk-im-context-simple";
      "gtk-theme" = "Adwaita-dark";
      # "icon-theme" = "Paper-Mono-Dark";
    };


    "org/gnome/desktop/input-sources" = {
      "sources" = [ (mkTuple [ "xkb" "gb" ]) ];
      "xkb-options" = [ "ctrl:swapcaps" ];
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
