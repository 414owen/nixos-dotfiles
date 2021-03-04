{ pkgs, ... }:
{
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nixcache.reflex-frp.org"
      "https://hydra.iohk.io"
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    daemonNiceLevel = 10;
    daemonIONiceLevel = 10;
    useSandbox = true;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
