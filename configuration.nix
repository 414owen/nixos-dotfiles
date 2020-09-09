{ config, pkgs, ... }:
let unstable = import <unstable> { config.allowUnfree = true; };
in
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;
  networking.hostName = "vps";
  services.openssh.enable = true;
  system.stateVersion = "20.03";
  programs.zsh.enable = true;
  programs.command-not-found.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.minecraft-server = {
    enable = true;
    declarative = true;
    eula = true;
    serverProperties = {
      motd = "frend!";
      white-list = false;
    };
    package = unstable.minecraft-server;
    openFirewall = true;
  };
  users.users.owen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = "/run/current-system/sw/bin/zsh";
  };
}

