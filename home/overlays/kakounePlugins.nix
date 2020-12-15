self: super: {
  kakounePlugins = super.kakounePlugins // {
    kakoune-easymotion = super.callPackage ../derivations/kakoune-easymotion.nix {};
  };
}
