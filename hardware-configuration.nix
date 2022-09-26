# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      # (import hardware.common.gpu.amd)
      # (import hardware.common.pc.laptop)
      # (import hardware.common.ps.laptop.ssd)

      <nixos-hardware/common/cpu/amd>
      <nixos-hardware/common/gpu/amd>
      <nixos-hardware/common/pc/laptop>
      <nixos-hardware/common/pc/laptop/ssd>
    ];

  # services.tlp.enable = true;
  # services.power-profiles-daemon.enable = false;
  # services.thermald.enable = true;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b4443c16-86c1-42af-bc2c-349bf3165163";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/d0a0c5ed-40d6-4dd0-a014-b2b89ce3be60";

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
