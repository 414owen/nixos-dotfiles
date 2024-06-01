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
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = ["FiraMono"]; })
      dejavu_fonts
      ubuntu_font_family
      liberation_ttf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
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
      xkb.layout = "gb";
      xkb.options = "ctrl:swapcaps";
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

    };
    libinput.enable = true;
    libinput.touchpad.tapping = true;
    libinput.touchpad.tappingDragLock = true;
  };
}
