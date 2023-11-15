{
  inputs.nixpkgs.url        = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.home-manager.url   = "github:nix-community/home-manager/master";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.nix-std.url        = "github:chessai/nix-std";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = args@{ nixpkgs, nix-std, home-manager, nixos-hardware, ... }: {

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = args;

      modules = [
        home-manager.nixosModules.home-manager
        nixos-hardware.nixosModules.common-pc
        nixos-hardware.nixosModules.common-pc-ssd
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        ./modules/common.nix
        ./machines/desktop
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = args;

      modules = [
        home-manager.nixosModules.home-manager
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-pc-laptop
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        ./modules/common.nix
        ./machines/laptop
      ];
    };
  };
}
