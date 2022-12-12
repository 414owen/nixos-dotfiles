{ pkgs, home, ... }:

{
  nix = {
    extraOptions = ''
      allowed-uris = https://github.com
      auto-optimise-store = true
    '';
    package = pkgs.nixUnstable;
    settings = {
      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = ["owen"];
    };
  };
}
