{
  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url   = "github:nix-community/home-manager/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-std.url        = "github:chessai/nix-std";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = args@{ self, nixpkgs, nix-std, home-manager, nixos-hardware, ... }: {

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
        ./modules/nix.nix
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
        ./modules/nix.nix
        ./machines/laptop
      ];
    };
  };
}
