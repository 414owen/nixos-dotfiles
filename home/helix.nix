{ pkgs, home, ... }:

{
  home.file.".config/helix/config.toml".text = ''
    [keys.normal]
    C-s = [
      "save_selection",
      "select_all",
      # Delete trailing whitespace from end of each line
      ":pipe sed 's/[ \t]*$//'",
      # Delete trailing blank lines (including whitespace) from end of the buffer
      ":pipe awk '/^\\s*$/ {b=b $0 \"\\n\"; next;} {printf \"%s\",b; b=\"\"; print;}'",
      "collapse_selection",
      "jump_backward",
      "commit_undo_checkpoint",
      ":write",
    ]

    [editor.indent-guides]
    render = true
  '';
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
    indent = { tab-width = 2, unit = "  " }
  '';
}
