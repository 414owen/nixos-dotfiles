{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/common.nix
    ./../../modules/graphical.nix
    ./../../modules/efi.nix
    ./../../modules/tiko.nix
    ./../../modules/no-mitigations.nix
  ];

  networking.hostName = "laptop";
  hardware.bluetooth.enable = true;
}

