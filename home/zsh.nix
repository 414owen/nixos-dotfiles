{ pkgs, ... }:

let
  aliases = import ./aliases.nix { pkgs = pkgs; };
in

{
  programs.zsh = {
    autocd = true;
    # enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      ignoreDups = true;
      # ignoreAllDups = true;
      expireDuplicatesFirst = true;
      share = true;
    };
    initExtra = ''
      setopt HIST_REDUCE_BLANKS
      setopt HIST_SAVE_NO_DUPS

      bindkey '^[[A' up-line-or-search
      bindkey '^[[B' down-line-or-search
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^X^E" edit-command-line
      ${builtins.readFile (./shell.sh)}
      ${import ./fns.nix { pkgs = pkgs; }}
    '';
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    shellAliases = aliases;
  };
}
