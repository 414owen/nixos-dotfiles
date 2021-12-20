{ pkgs, ... }:

{
  home.file.".config/kak-lsp/kak-lsp.toml".text = ''
    snippet_support = true
    verbosity = 2

    [language.haskell]
    filetypes = ["haskell"]
    roots = ["Setup.hs", "stack.yaml", "*.cabal"]
    command = "haskell-language-server-wrapper"
    args = ["--lsp"]

    [language.ruby]
    filetypes = ["ruby"]
    roots = ["Gemfile"]
    command = "solargraph"
    args = ["stdio"]

    [language.rust]
    filetypes = ["rust"]
    roots = ["Cargo.toml"]
    command = "rls"

    [language.javascript]
    filetypes = ["javascript"]
    roots = [".js"]
    command = "typescript-language-server"
    args = ["--stdio"]

    [language.terraform]
    filetypes = ["terraform"]
    roots = [".tf"]
    command = "terraform-lsp"
    args = ["-enable-log-file", "-log-location", "/tmp/"]

    [language.c_cpp]
    filetypes = ["c", "cpp"]
    roots = [".c-lang-serv", "makefile", "Makefile"]
    command = "clangd"
    args = []


    # Semantic tokens support
    # See https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_semanticTokens
    # for the default list of tokens and modifiers.
    # However, many language servers implement their own values.
    # Make sure to check the output of `lsp-capabilities` and each server's documentation and source code as well.
    # Examples:
    # - TypeScript: https://github.com/microsoft/vscode-languageserver-node/blob/2645fb54ea1e764aff71dee0ecc8aceff3aabf56/client/src/common/semanticTokens.ts#L58
    # - Rust Analyzer: https://github.com/rust-analyzer/rust-analyzer/blob/f6da603c7fe56c19a275dc7bab1f30fe1ad39707/crates/ide/src/syntax_highlighting.rs#L42

    [[semantic_tokens]]
    token = "comment"
    face = "documentation"
    modifiers = ["documentation"]

    [[semantic_tokens]]
    token = "comment"
    face = "comment"

    [[semantic_tokens]]
    token = "function"
    face = "function"

    [[semantic_tokens]]
    token = "keyword"
    face = "keyword"

    [[semantic_tokens]]
    token = "namespace"
    face = "module"

    [[semantic_tokens]]
    token = "operator"
    face = "operator"

    [[semantic_tokens]]
    token = "string"
    face = "string"

    [[semantic_tokens]]
    token = "type"
    face = "type"

    [[semantic_tokens]]
    token = "variable"
    face = "default+d"
    modifiers = ["readonly"]

    [[semantic_tokens]]
    token = "variable"
    face = "default+d"
    modifiers = ["constant"]

    [[semantic_tokens]]
    token = "variable"
    face = "variable"

  '';
}
