{ pkgs, home, ... }:

{
  nix = {
    registry.nixpkgs.flake = pkgs;

    extraOptions = ''
      allowed-uris = https://github.com
      auto-optimise-store = true
    '';
    package = pkgs.nixUnstable;
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "http://hydra.tiko.ch/"
        "https://cache.iog.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hydra.tiko.ch:q8EX+cmvjysdFOPttZEl30cMv5tnB2dddkwrC61qdA4="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      trusted-users = ["owen"];
    };
  };
}
