{ pkgs, home, ... }:

{
  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = ["owen"];
      trusted-substituters = [
        "https://cache.nixos.org"
        "http://hydra.tiko.ch/"
        "https://iohk.cachix.org"
        "https://hydra.iohk.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hydra.tiko.ch:q8EX+cmvjysdFOPttZEl30cMv5tnB2dddkwrC61qdA4="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      ];
    };
  };
}
