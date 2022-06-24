# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./cachix.nix
      ./hardware-configuration.nix
      ./make-linux-fast-again.nix
      <nixos-hardware/dell/xps/13-9370>
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.gvfs.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  services.localtime.enable = true;
  time.timeZone = "Europe/Dublin";
  i18n.defaultLocale = "en_GB.UTF-8";
  services.xserver.enable = true;
  virtualisation.docker.enable = true;

  services = {
    openssh = {
      enable = true;
      # passwordAuthentication = false: Authenticate using file
      # passwordAuthentication = true: Enter password to authenticate
      passwordAuthentication = true;
    };

    openvpn.servers = { 
      # NOTE: You probably want to modify this!
      # This uses the old openVPN configuration, and may need to be tinkered with.
      # See also https://tikoenergy.atlassian.net/wiki/spaces/DOPS/pages/283639809/OpenVPN+for+tiko+employee#For-Linux-users-only%3A
      officeVPN = {
        config = '' config /home/owen/.sec/profile-162.ovpn '';
        updateResolvConf = true;
        autoStart = false;
      };
    };
  };

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kakoune # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    exfat
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  services.tlp.enable = false;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # fileSystems."/media/external-drive" = {
  #   device = "192.168.0.65:/media/external-drive";
  #   options = [ "x-systemd.automount" "noauto" "user" ];
  #   fsType = "nfs";
  # };

  # fileSystems."/media/drive2" = {
  #   device = "192.168.0.65:/media/drive2";
  #   options = [ "x-systemd.automount" "noauto" ];
  #   fsType = "nfs";
  # };

  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;


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
}

