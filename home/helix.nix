{ pkgs, home, ... }:

{
  home.file.".config/helix/config.toml".text = ''
    # theme = "base16_terminal"
    theme = "rose_pine"

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


    [editor.cursor-shape]
    insert = "bar"
    normal = "block"
    select = "underline"

    [editor.whitespace.characters]
    # space = "·"
    nbsp = "⍽"
    tab = "→"
    newline = "⏎"
    tabpad = "·" # Tabs will look like "→···" (depending on tab width)
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
    roots = ["Setup.hs", "stack.yaml", "*.cabal", "cabal.project", "cabal.project.freeze"]
    comment-token = "--"
    language-server = { command = "haskell-language-server", args = ["--lsp"] }
    indent = { tab-width = 2, unit = "  " }

    [[language]]
    name = "nix"
    scope = "source.nix"
    injection-regex = "nix"
    file-types = ["nix"]
    shebangs = []
    roots = []
    comment-token = "#"
    language-server = { command = "nil" }
    indent = { tab-width = 2, unit = "  " } 
  '';
}
