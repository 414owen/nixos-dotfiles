self: super: {
  kakounePlugins = super.kakounePlugins // {
    kakboard = super.callPackage ./derivations/kakboard.nix { };
  };
}
