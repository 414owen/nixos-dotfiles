{ pkgs, nixpkgs, home-manager, ... }: {

  environment.etc."nix/channels/nixpkgs".source = nixpkgs.outPath;
  environment.etc."nix/channels/home-manager".source = home-manager.outPath;

  nix.nixPath = [ 
    "nixpkgs=/etc/nix/channels/nixpkgs"
    "home-manager=/etc/nix/channels/home-manager"
  ];

  nix.settings.experimental-features = "nix-command flakes";

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
}
