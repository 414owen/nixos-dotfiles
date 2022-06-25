# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "ctrl:nocaps";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    kakoune
    wget
    firefox
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.tlp.enable = false;


  nix = {
    useSandbox = true;
    package = pkgs.nixUnstable;
    binaryCaches = [
      "https://cache.nixos.org"
      "http://hydra.tiko.ch/"
      "https://iohk.cachix.org"
      "https://hydra.iohk.io"
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hydra.tiko.ch:q8EX+cmvjysdFOPttZEl30cMv5tnB2dddkwrC61qdA4="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
  };

  system.stateVersion = "22.05"; # Did you read the comment?
}

