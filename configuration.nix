# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, rust-overlay, ... }:

{
  imports = [
    # ./cachix.nix
    ./nix.nix
    ./games.nix
    ./hardware-configuration.nix
  ];

  nix.nixPath = [ 
    "nixpkgs=/etc/nix/channels/nixpkgs"
    "home-manager=/etc/nix/channels/home-manager"
  ];

  nix.settings.experimental-features = "nix-command flakes";

  home-manager.useGlobalPkgs = true;

  fonts.fontDir.enable = true;
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "owen" ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    alsa.support32Bit = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    fira
    fira-code
    fira-code-symbols
    ubuntu_font_family
    roboto
    inconsolata
    cascadia-code
    hermit
    iosevka
    jost
    # monoid
    # virtualbox
    montserrat
    mononoki
    pecita
    overpass
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
  # boot.kernelPackages = pkgs.linuxPackages_5_16;
  services.gvfs.enable = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.localtimed.enable = true;
  time.timeZone = "Europe/Paris";
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

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "plugdev" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  home-manager.users.owen = import ./home/home.nix;

  environment.systemPackages = with pkgs; [
    kakoune
    wget
    firefox
    pkgs.rust-bin.stable.latest.default
    rust-analyzer
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ rust-overlay.overlays.default ];
  };

  system.stateVersion = "22.11"; # Did you read the comment?
}
