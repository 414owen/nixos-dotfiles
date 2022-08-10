let
  pkgs = import (builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-for-hydra-unstable";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "c82b46413401efa740a0b994f52e9903a4f6dcd5";
  });
in

self: super: {
  hydra-unstable = super.hydra-unstable.overrideAttrs (attrs: {
    patches = [
      # hack for https://github.com/input-output-hk/haskell.nix/issues/495
      # ./hydra_unrestricted_eval.diff
      # ./hydra_submodules.diff
      ../patches/hydra-submodules.patch
    ];
  });
}
