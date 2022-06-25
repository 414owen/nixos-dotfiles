self: super: {
  kakounePlugins = super.kakounePlugins // {
    kakboard = super.callPackage ./derivations/kakboard.nix { };
    kak-fzf = super.kakounePlugins.kak-fzf.overrideAttrs (attrs: attrs // {
      src = super.fetchFromGitHub {
        owner = "andreyorst";
        repo = "fzf.kak";
        rev = "1b3a3beebbe7134e671fde2ef2f4242b34ae2c60";
        sha256 = "0rsd65zcizbq3isy8576gqw7mcml5ixw84padaz6ndwfif5fv701";
      };
    });
  };
}
