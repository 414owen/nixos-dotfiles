# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nix.nix
      <home-manager/nixos>
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.localtime.enable = true;
  time.timeZone = "Europe/Dublin";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = true;
    };

    openvpn.servers = { 
      officeVPN = {
        config = '' config /home/owen/.sec/profile-162.ovpn '';
        updateResolvConf = true;
        autoStart = false;
      };
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

    hydra = {
      enable = false;
      hydraURL = "http://localhost:3000";
      notificationSender = "hydra@localhost";
      buildMachinesFiles = [];
      useSubstitutes = true;
      extraConfig = ''
        <gitlab_authorization>
        owen.shepherd@tiko.energy=glpat-Y19nsDS9oWjUxxksA88j
        36=glpat-Y19nsDS9oWjUxxksA88j
        </gitlab_authorization>
      '';
    };
  };

  programs.ssh.knownHosts = {
    "gitlab.internal.tiko.ch" = {
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFVew5uYF6vDHk6olO3cIfLzNQ1mqrSu33Zj68k2Awd";
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager.users.owen = import ./home/home.nix;

  environment.systemPackages = with pkgs; [
    kakoune
    wget
    firefox
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # fileSystems."/media/external-drive" = {
  #   device = "192.168.0.65:/media/external-drive";
  #   options = [ "x-systemd.automount" "noauto" "user" ];
  #   fsType = "nfs";
  # };

  # fileSystems."/media/drive2" = {
  #   device = "192.168.0.65:/media/drive2";
  #   options = [ "x-systemd.automount" "noauto" "user" ];
  #   fsType = "nfs";
  # };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import <rust-overlay>)
      (import ./overlays/hydra.nix)
    ];
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}
