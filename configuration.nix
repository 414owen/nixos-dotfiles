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

  fonts.fontDir.enable = true;
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # alsa.support32Bit = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  services.pcscd.enable = true;
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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.gvfs.enable = true;

  networking.hostName = "nixos-arm";
  networking.networkmanager.enable = true;

  services.localtimed.enable = true;
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = true;
    };

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

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

  home-manager.users.owen = import ./home/home.nix;

  environment.systemPackages = with pkgs; [
    helix
    wget
    firefox
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ ];
  };

  system.stateVersion = "22.11"; # Did you read the comment?
}
