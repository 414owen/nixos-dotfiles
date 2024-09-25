{ pkgs, home, nix-std, ... }:

{
  home.file.".config/helix/config.toml".text = nix-std.lib.serde.toTOML {
    theme = "base16_terminal";
    # theme = "rose_pine"

    keys.normal = {
      C-s = [
        "save_selection"
        "select_all"
        # Delete trailing whitespace from end of each line
        ":pipe sed 's/[ \t]*$//'"
        # Delete trailing blank lines (including whitespace) from end of the buffer
        ":pipe awk '/^\\s*$/ {b=b $0 \"\\n\"; next;} {printf \"%s\",b; b=\"\"; print;}'"
        "collapse_selection"
        "jump_backward"
        "commit_undo_checkpoint"
        ":write"
      ];
      esc = ["collapse_selection" "keep_primary_selection"];
    };

    editor.indent-guides = {
      render = false;
    };

    editor.cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };

    editor.whitespace.characters = {
      # space = "·"
      nbsp = "⍽";
      tab = "→";
      newline = "⏎";
      # Tabs will look like "→···" (depending on tab width)
      tabpad = "·";
    };
  };

  home.file.".config/helix/languages.toml".text = nix-std.lib.serde.toTOML {
    language-server.haskell-language-server-wrapper = {
      command = "haskell-language-server-wrapper";
      args = ["--lsp"];
    };
    language-server.haskell-language-server = {
      command = "haskell-language-server";
      args = ["--lsp"];
    };
    language-server.pylsp = { command = "pylsp"; };
    language-server.pylyzer = {
      command = "pylyzer";
      args = ["--server"];
    };
    language = [
      {
        name = "rust";
        scope = "source.rust";
        injection-regex = "rust";
        file-types = ["rs"];
        roots = ["Cargo.toml" "Cargo.lock"];
        auto-format = true;
        language-servers = ["rust-analyzer"];
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
      {
        name = "haskell";
        scope = "source.haskell";
        injection-regex = "haskell";
        file-types = ["hs"];
        roots = ["Setup.hs" "stack.yaml" "*.cabal" "cabal.project" "cabal.project.freeze"];
        language-servers = [
          "haskell-language-server"
          "haskell-language-server-wrapper"
        ];
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
      {
        name = "python";
        scope = "source.python";
        injection-regex = "py(thon)?";
        file-types = ["py" "pyi" "py3" "pyw" "ptl" "rpy" "cpy" "ipy" "pyt"
          { glob = ".python_history"; }
          { glob = ".pythonstartup"; }
          { glob = ".pythonrc"; }
          { glob = "SConstruct"; }
          { glob = "SConscript"; }];
        shebangs = ["python"];
        roots = ["pyproject.toml" "setup.py" "poetry.lock" "pyrightconfig.json"];
        comment-token = "#";
        language-servers = ["pylsp"];
        indent = { tab-width = 4; unit = "    "; };
      }
    ];
  };
}
