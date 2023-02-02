# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # ./cachix.nix
    ./nix.nix
    ./hardware-configuration.nix
  ];

  security.polkit.enable = true;
  fonts.fontDir.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  fonts = {
     fonts = with pkgs; [
      (nerdfonts.override { fonts = ["FiraCode" "RobotoMono"]; })
      ubuntu_font_family
      liberation_ttf
      fira-code
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Ubuntu Mono" ];
        sansSerif = [ "Ubuntu" ];
        serif     = [ "Liberation Serif" ];
      };
    };
  };

  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  networking = {
    firewall.enable = false;
    # nameservers = [ "1.0.0.1" "1.1.1.1" ];
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
    pulseaudio.enable = false;
  };

  environment = {
    # for zsh completions of system packages
    pathsToLink = [ "/share/zsh" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-arm";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = {

    gvfs.enable = true;

    thermald.enable = false;
    pcscd.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      # alsa.support32Bit = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;
    };

    udisks2.enable = true;

    xserver = {
      enable = false;
      layout = "gb";
      xkbOptions = "ctrl:nocaps";

      libinput.touchpad.tapping = true;
      libinput.touchpad.tappingDragLock = true;
    };

  };

  sound.enable = true;

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager = {
    users.owen = import ./home/home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  environment.systemPackages = with pkgs; [
    helix
    wget
    udiskie
    pmutils
    libnotify
    fuzzel
    xfce.thunar
    xfce.thunar-volman
    ranger
    joshuto
    firefox
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ ];
  };

  system.stateVersion = "22.11"; # Did you read the comment?
}
