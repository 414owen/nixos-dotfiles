{ pkgs, ... }:

let
  aliases = import ./aliases.nix { pkgs = pkgs; };
  darwinAliases = import ./aliases-darwin.nix;
  linuxAliases = import ./aliases-linux.nix;
in

{
  programs.zsh = {
    enable = true;
    autocd = true;
    # autosuggestion = {
    #   enable = true;
    #   highlight = true;
    # };
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
    history = {
      extended = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
      ignorePatterns = [
        "cd *"
        "rm *"
      ];
    };
    initExtra = ''
      bindkey '^[[A' up-line-or-search
      bindkey '^[[B' down-line-or-search
      autoload -z edit-command-line.
      zle -N edit-command-line
      bindkey "^X^E" edit-command-line
      ${builtins.readFile (./shell.zsh)}
      ${import ./fns.nix { pkgs = pkgs; }}
    '';
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    shellAliases = aliases
      // (if pkgs.stdenv.isDarwin then darwinAliases else linuxAliases);
  };
}
