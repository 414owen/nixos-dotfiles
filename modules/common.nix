{ config, pkgs, options, nix-std, nixpkgs-stable, ... }:

{
  # update microcode
  hardware.enableRedistributableFirmware = true;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.extraSpecialArgs = {
    inherit nix-std nixpkgs-stable;
  };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    enableSSHSupport = true;
  };

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
    # nameservers = [ "1.0.0.1" "1.1.1.1" ];
  };

  environment = {
    # for zsh completions of system packages
    pathsToLink = [ "/share/zsh" ];
  };

  services.localtimed.enable = true;

  environment = {
    systemPackages = with pkgs; [
      bind
      pmutils
      dconf
      file
      traceroute
      tree
      unzip
      wget
    ];
  };

  programs = {
    zsh.enable = true;
    mosh.enable = true;
  };

  sound.enable = true;
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_GB.UTF-8";

  nixpkgs.config.allowUnfree = true;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  console.useXkbConfig = true;

  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "plugdev" "render" "video" ];
    shell = pkgs.zsh;
  };

  zramSwap = {
    enable = true;
    priority = 5;
    memoryPercent = 50;
  };
  
  system = {
    stateVersion = "22.11";

    extraSystemBuilderCmds = ''
      ln -sv ${pkgs.path} $out/nixpkgs
    '';
  };
}
