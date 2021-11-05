{ pkgs, ... }:

{
  home.file.".config/kak-lsp/kak-lsp.toml".text = ''
    snippet_support = true
    verbosity = 2

    [semantic_scopes]
    # Map textmate scopes to kakoune faces for semantic highlighting
    # the underscores are translated to dots, and indicate nesting.
    # That is, if variable_other_field is omitted, it will try the face for
    # variable_other and then variable
    #
    # To see a list of available scopes in the debug buffer, run lsp-semantic-available-scopes
    variable = "variable"
    entity_name_function = "function"
    entity_name_type = "type"
    variable_other_enummember = "variable"
    entity_name_namespace = "module"

    # Semantic tokens support
    # See https://github.com/microsoft/vscode-languageserver-node/blob/8c8981eb4fb6adec27bf1bb5390a0f8f7df2899e/client/src/semanticTokens.proposed.ts#L288
    # for token/modifier types.

    [semantic_tokens]
    type = "type"
    variable = "variable"
    namespace = "module"
    function = "function"
    string = "string"
    keyword = "keyword"
    operator = "operator"
    comment = "comment"

    [semantic_modifiers]
    documentation = "documentation"
    readonly = "default+d"

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

    [language.idris]
    filetypes = ["idris"]
    roots = [".ipkg"]
    command = "idris2-lsp"
    args = []
  '';
}
