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
    indent = { tab-width = 4, unit = "    " }
    [language.config]
    cargo = { loadoutdirsfromcheck = true }
    procmacro = { enable = false }
  '';
}
