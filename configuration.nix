{ config, pkgs, options, ... }:

{

  imports = [
    ./boot.nix
    ./cachix.nix
    ./nix.nix
    ./nixpkgs.nix
    ./hardware-configuration.nix
    ./make-linux-fast-again.nix
    <nixos-hardware/dell/xps-9370>
  ];

  time.timeZone = "Europe/Dublin";

  # boot.kernelPackages = pkgs.linuxPackages_5_7;

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  hardware = {
    bluetooth.enable = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {

    # for zsh completions of system packages
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      bind
      file
      fira-code
      firmwareLinuxNonfree
      numix-icon-theme
      numix-icon-theme-circle
      ntfs3g
      paper-icon-theme
      patchelf
      python3Full
      service-wrapper
      steam
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
      desktopManager = {
        gnome3.enable = true;
      };
      displayManager = {
        # defaultSession = "gnome";
        gdm = {
          enable = true;
          autoLogin = {
            enable = false;
            user = "owen";
          };
        };
      };
      libinput = {
        enable = true;
        disableWhileTyping = false;
      };
      xkbOptions = "ctrl:swapcaps";
    };
    keybase.enable = true;
  };

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "disk" "networkmanager" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  system.stateVersion = "20.03";
}
