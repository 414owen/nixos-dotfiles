{ pkgs, ... }:

{
  home.file.".config/kak-lsp/kak-lsp.toml".text = ''
    snippet_support = true
    verbosity = 2

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
    command = "rust-analyzer"

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

    [language.d]
    filetypes = ["d", "di"]
    roots = [".git", "dub.sdl", "dub.json"]
    command = "serve-d"

    [language.idris]
    filetypes = ["idris"]
    roots = [".ipkg"]
    command = "idris2-lsp"
    args = []
  '';
}
