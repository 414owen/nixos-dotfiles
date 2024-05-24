{ pkgs, home, ... }:

{
  nix = {
  
    extraOptions = ''
      allowed-uris = https://github.com
      auto-optimise-store = true
    '';

    nixPath = [ 
      "nixpkgs=/run/current-system/nixpkgs"
    ];

    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = ["owen"];
      extra-substituters = [
        "https://cache.lix.systems"
      ];
      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      ];
    };
  };
}
