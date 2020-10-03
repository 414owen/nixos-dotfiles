{ pkgs, ... }:

let
  aliases = import ./aliases.nix;
in

{
  programs.zsh = {
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      ignoreDups = true;
      share = true;
    };
    initExtra = ''
      if [ -z "$TMUX" ]; then
        tmux
      else
        eval "$(${pkgs.fasd}/bin/fasd --init auto)"
        . ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ${builtins.readFile (./shell.zsh)}
        ${builtins.readFile (./fns.sh)}
        ${import ./fns.nix { pkgs = pkgs; }}
      fi
    '';
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    shellAliases = aliases;
  };
}
