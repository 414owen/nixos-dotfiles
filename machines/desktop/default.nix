{ pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/common.nix
    ./../../modules/graphical.nix
    ./../../modules/efi.nix
    ./../../modules/tiko.nix
    ./../../modules/no-mitigations.nix
  ];

  networking.hostName = "desktop";
  hardware.bluetooth.enable = false;
  services.openssh.enable = true;
}

