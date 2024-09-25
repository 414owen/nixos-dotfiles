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
        "https://nixcache.reflex-frp.org"
      ];
      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      ];
    };
  };
}
