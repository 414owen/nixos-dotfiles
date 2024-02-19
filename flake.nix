{
  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url   = "github:nix-community/home-manager/release-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-std.url        = "github:chessai/nix-std";
    nix-darwin.url     = "github:LnL7/nix-darwin";

    nix-darwin.inputs.nixpkgs.follows   = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = args@{ self, nixpkgs, nix-std, nix-darwin, home-manager, nixos-hardware, ... }: {

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

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#bsd-nix
    darwinConfigurations."bsd-nix" = nix-darwin.lib.darwinSystem {
      specialArgs = args;
      modules = [
        home-manager.darwinModule
        ./modules/nix.nix
        ./machines/mbp
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."bsd-nix".pkgs;
  };
}
