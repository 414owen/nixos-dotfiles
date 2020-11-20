{ config, pkgs, options, ... }:

{

  imports = [
    ./boot.nix
    ./cachix.nix
    ./fonts.nix
    ./nix.nix
    ./nixpkgs.nix
    ./hardware-configuration.nix
    ./make-linux-fast-again.nix
    <nixos-hardware/lenovo/thinkpad/t490>
  ];

  time.timeZone = "Europe/Dublin";

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  virtualisation.docker.enable = true;

  environment = {

    # for zsh completions of system packages
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      bind
      file
      fira-code
      numix-icon-theme
      numix-icon-theme-circle
      paper-icon-theme
      patchelf
      python3Full
      service-wrapper
      traceroute
      tree
      unzip
      wget
      wirelesstools
      xf86_input_wacom
      xorg.libxcb
      xsel
    ];
  };

  programs.zsh.enable = true;
  programs.command-not-found.enable = true;

  sound.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      desktopManager.gnome3.enable = true;
      displayManager = {
        defaultSession = "gnome";
        gdm.enable = true;
        gdm.autoLogin = {
          enable = true;
          user = "oshepherd";
        };
      };
      libinput = {
        enable = true;
        disableWhileTyping = false;
      };
      xkbOptions = "ctrl:swapcaps";
    };
  };

  users.users.oshepherd = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" "audio" "video" "disk" "networkmanager" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  system.stateVersion = "20.03";
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
}
