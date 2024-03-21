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
    # enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      ignoreDups = true;
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
    shellAliases = aliases
      // (if pkgs.stdenv.isDarwin then darwinAliases else linuxAliases);
  };
}
