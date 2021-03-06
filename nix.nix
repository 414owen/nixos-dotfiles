{ ... }:
{
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nixcache.reflex-frp.org" 
    ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];
    daemonNiceLevel = 10;
    daemonIONiceLevel = 10;
  };
}
