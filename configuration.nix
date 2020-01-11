{ config, pkgs, options, ... }:

{

  imports = [
    ./boot.nix
    ./cachix.nix
    ./games.nix
    ./nix.nix
    ./nixpkgs.nix
    ./hardware-configuration.nix
    ./kernel-params.nix
    <musnix>
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/cpu/amd>
  ];

  time.timeZone = "Europe/Dublin";

  # boot.kernelPackages = pkgs.linuxPackages_5_7;
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "owen" ];

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
    virtualbox
    montserrat
    mononoki
    pecita
    overpass
  ];

  musnix = {
    enable = true;
    # soundCardPciId = "0c:00.4";
    kernel = {
      optimize = false;
      realtime = false;
      # packages = pkgs.linuxPackages_latest_rt;
    };
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
      xorg.libxcb
      xsel
    ];
  };

  programs = {
    zsh.enable = true;
    mosh.enable = true;
    command-not-found.enable = true;
    adb.enable = true;
  };

  sound.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      desktopManager = {
        gnome3.enable = true;
      };
      displayManager = {
        defaultSession = "gnome";
        autoLogin = {
          enable = false;
          user = "owen";
        };
        gdm.enable = true;
      };
      libinput = {
        enable = true;
        disableWhileTyping = false;
      };
      xkbOptions = "ctrl:swapcaps";
      videoDrivers = [ "amdgpu" ];
    };
    keybase.enable = true;
    sshd.enable = true;
    jack = {
      jackd.enable = true;
      alsa.enable = false;
      loopback.enable = true;
    };
  };
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;


  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "video" "disk" "networkmanager" "adbusers" "tty" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  # services.cassandra.enable = true;
  # services.redis.enable = true;
  # services.apache-kafka.enable = true;
  virtualisation.docker.extraOptions = let file = pkgs.writeText "daemon.json"
    (builtins.toJSON { default-address-pools = [ { base = "192.168.128.0/18"; size = 24; } ]; });
  in "--config-file=${file}";

  system.stateVersion = "20.09";
}
