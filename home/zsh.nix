{ pkgs, ... }:

let
  aliases = import ./aliases.nix { pkgs = pkgs; };
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
    initExtraBeforeCompInit = ''
      if [ "$TERM" = "alacritty" ]; then
        if [ -z "$TMUX" ]; then
          tmux
          exit
        fi
      fi
    '';
    initExtra = ''
      . ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ${builtins.readFile (./shell.zsh)}
      ${import ./fns.nix { pkgs = pkgs; }}
    '';
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    shellAliases = aliases;
  };
}
