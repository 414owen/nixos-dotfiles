{
  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    home-manager.url   = "github:nix-community/home-manager/release-23.11";
    nix-std.url        = "github:chessai/nix-std";
    nix-darwin.url     = "github:LnL7/nix-darwin";

    nix-darwin.inputs.nixpkgs.follows   = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = args@{ self, nixpkgs, nix-std, nix-darwin, home-manager, ... }: {

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#bsd-nix
    darwinConfigurations."bsd-nix" = nix-darwin.lib.darwinSystem {
      specialArgs = args;
      modules = [
        home-manager.darwinModule
        ../../modules/nix.nix
        ./default.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."bsd-nix".pkgs;
  };
}
