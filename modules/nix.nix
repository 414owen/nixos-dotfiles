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
    };

    package = pkgs.nixVersions.unstable;
  };
}
