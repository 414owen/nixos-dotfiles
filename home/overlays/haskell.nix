self: super: {
  pp-ghci = with super.haskell.lib; doJailbreak (dontHaddock (super.haskellPackages.callCabal2nix "ghci-pretty" (import ../nix/sources.nix).pretty-ghci {}));
}
