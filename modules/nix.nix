{ pkgs, home, ... }:

{
  nix = {
    package = pkgs.nixUnstable;

    extraOptions = ''
      allowed-uris = https://github.com
      auto-optimise-store = true
    '';

    nixPath = [ 
      "nixpkgs=/etc/nix/channels/nixpkgs"
      "home-manager=/etc/nix/channels/home-manager"
    ];

    settings.experimental-features = "nix-command flakes";
  };
}
