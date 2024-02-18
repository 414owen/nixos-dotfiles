{ config, pkgs, rust-overlay, options, ... }:

{
  imports = [
    ./fonts.nix
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "Ubuntu Mono" ];
        sansSerif = [ "Ubuntu" ];
        serif     = [ "Liberation Serif" ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      dconf
      gnome.file-roller
    ];
  };

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      libinput.enable = true;
      xkbOptions = "ctrl:swapcaps";

      libinput.touchpad.tapping = true;
      libinput.touchpad.tappingDragLock = true;
    };
  };
}
