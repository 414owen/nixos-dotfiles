{ pkgs, home, ... }:

{
  nix = {
    extraOptions = ''
      allowed-uris = https://github.com
      auto-optimise-store = true
    '';
    package = pkgs.nixUnstable;
    settings = {
      trusted-users = ["owen"];
    };
  };
}
