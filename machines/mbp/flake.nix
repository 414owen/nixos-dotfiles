{

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url   = "github:nix-community/home-manager/master";
    nix-std.url        = "github:chessai/nix-std";
    nix-darwin.url     = "github:LnL7/nix-darwin";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.inputs.nixpkgs.follows   = "nixpkgs";
  };

  outputs = args@{ self, nixpkgs, nix-std, nix-darwin, home-manager, ... }: {

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#bsd-nix
    darwinConfigurations."bsd-nix" = nix-darwin.lib.darwinSystem {
      specialArgs = args;
      modules = [
        home-manager.darwinModule
        ./default.nix
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."bsd-nix".pkgs;
  };
}
