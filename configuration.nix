{ config, pkgs, options, ... }:

{

  imports = [
    ./boot.nix
    # ./cachix.nix
    ./games.nix
    ./nixpkgs.nix
    ./hardware-configuration.nix
    ./kernel-params.nix
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/cpu/amd>
    <home-manager/nixos>
  ];

  time.timeZone = "Europe/Dublin";

  fonts.fontDir.enable = true;
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "owen" ];

  nix = {
    binaryCaches = [ "https://nixcache.reflex-frp.org" ];
    binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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
    pulseaudio.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  home-manager.users.owen = import ./home/home.nix;

  environment = {

    # for zsh completions of system packages
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      bind
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

  # security.rtkit.enable = true;

  # services.pipewire = {
  #   enable = true;
  #   # package = nixos-unstable.pipewire;
  #   alsa = {
  #     enable = true;
  #     support32Bit = true;
  #   };
  #   pulse.enable = true;
  # };

  sound.enable = true;

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      desktopManager = {
        gnome.enable = true;
      };
      displayManager = {
        defaultSession = "gnome";
        autoLogin = {
          enable = true;
          user = "owen";
        };
        gdm = {
          enable = true;
        };
      };
      libinput.enable = true;
      xkbOptions = "ctrl:swapcaps";
      videoDrivers = [ "amdgpu" ];
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

  # services.cassandra.enable = true;
  # services.redis.enable = true;
  # services.apache-kafka.enable = true;
  # virtualisation.docker.extraOptions = let file = pkgs.writeText "daemon.json"
  #   (builtins.toJSON { default-address-pools = [ { base = "192.168.128.0/18"; size = 24; } ]; });
  # in "--config-file=${file}";

  system.stateVersion = "22.05";
}
