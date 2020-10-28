{ config, pkgs, options, ... }:

{

  imports = [
    ./boot.nix
    ./cachix.nix
    ./games.nix
    ./nix.nix
    ./nixpkgs.nix
    ./hardware-configuration.nix
    ./make-linux-fast-again.nix
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/cpu/amd>
  ];

  time.timeZone = "Europe/Dublin";

  # boot.kernelPackages = pkgs.linuxPackages_5_7;
  virtualisation.docker.enable = true;
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
        # xfce.enable = true;
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
      # videoDrivers = [ "amdgpu" ];
    };
    keybase.enable = true;
    sshd.enable = true;
  };

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "video" "disk" "networkmanager" "adbusers" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  system.stateVersion = "20.03";
}
