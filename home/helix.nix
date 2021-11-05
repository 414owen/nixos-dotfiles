{ pkgs, home, ... }:

{
  home.file.".config/helix/languages.toml" = {
    source = pkgs.writeText "zoomconfig" ''
      [[language]]
      name = "haskell"
      scope = "source.haskell"
      injection-regex = "haskell"
      file-types = ["hs"]
      roots = []
      comment-token = "--"
      indent = { tab-width = 2, unit = "  " }
      language-server = { command = "haskell-language-server" }
    '';
  };
}
