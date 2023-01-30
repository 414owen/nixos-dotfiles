{ config, pkgs, options, ... }:

{

  imports = [
    ./boot.nix
    # ./cachix.nix
    ./games.nix
    ./nix.nix
    ./hardware-configuration.nix
    ./kernel-params.nix
  ];

  fonts.fontDir.enable = true;
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "owen" ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
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
    networkmanager.enable = true;
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

  nix = {
    settings = {
      trusted-public-keys = [
        "hydra.tiko.ch:q8EX+cmvjysdFOPttZEl30cMv5tnB2dddkwrC61qdA4="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      substituters = [
        "https://cache.iog.io"
        "http://hydra.tiko.ch/"
      ];
    };
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  home-manager.users.owen = import ./home/home.nix;

  environment = {

    # for zsh completions of system packages
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      bind
      bemenu
      dconf
      dwl
      file
      firmwareLinuxNonfree
      ntfs3g
      patchelf
      python3Full
      service-wrapper
      traceroute
      tree
      unzip
      wget
      wirelesstools
      xsel
    ];
  };

  programs = {
    zsh.enable = true;
    mosh.enable = true;
    command-not-found.enable = true;
  };

  sound.enable = true;
  networking.hostName = "nixos";

  services.localtimed.enable = true;
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
    xserver = {
      enable = false;
      layout = "gb";
      # desktopManager = {
      #   gnome.enable = true;
      # };
      # displayManager = {
      #   defaultSession = "gnome";
      #   autoLogin = {
      #     enable = true;
      #     user = "owen";
      #   };
      #   gdm = {
      #     enable = true;
      #   };
      # };
      libinput.enable = true;
      xkbOptions = "ctrl:swapcaps";
      videoDrivers = [ "amdgpu" ];
    };
    openvpn.servers = {
      officeVPN = {
        config = '' config /home/owen/.sec/profile-162.ovpn '';
        updateResolvConf = true;
        autoStart = false;
      };
    };
    sshd.enable = true;
  };
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  console.useXkbConfig = true;

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "video" "disk" "networkmanager" "adbusers" "tty" "dialout" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 50;
  };

  # services.cassandra.enable = true;
  # services.redis.enable = true;
  # services.apache-kafka.enable = true;
  # virtualisation.docker.extraOptions = let file = pkgs.writeText "daemon.json"
  #   (builtins.toJSON { default-address-pools = [ { base = "192.168.128.0/18"; size = 24; } ]; });
  # in "--config-file=${file}";

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ ];
  };

  system.stateVersion = "22.11"; # Did you read the comment?
}
