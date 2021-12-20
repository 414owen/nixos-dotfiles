{ pkgs, home, ... }:

{
  home.file.".config/helix/languages.toml".text = ''

    [[language]]
    name = "rust"
    scope = "source.rust"
    injection-regex = "rust"
    file-types = ["rs"]
    roots = []
    auto-format = true
    comment-token = "//"
    language-server = { command = "rust-analyzer" }
    indent = { tab-width = 2, unit = "  " }

    [language.config]
    cargo = { loadoutdirsfromcheck = true }
    procmacro = { enable = false }

    [[language]]
    name = "haskell"
    scope = "source.haskell"
    injection-regex = "haskell"
    file-types = ["hs"]
    roots = []
    auto-format = false
    comment-token = "--"
    language-server = { command = "haskell-language-server", args = ["-d", "-l", "/home/owen/lsp.log"] }
    indent = { tab-width = 2, unit = "  " }
  '';
}
