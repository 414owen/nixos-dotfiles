self: super: {
  kakounePlugins = super.kakounePlugins // {
    kakoune-easymotion = super.callPackage ../derivations/kakoune-easymotion.nix {};
    kakboard = super.callPackage ../derivations/kakboard.nix {};
  };
}
