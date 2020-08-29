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
      eval "$(${pkgs.fasd}/bin/fasd --init auto)"
      . ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      . ${"${(builtins.fetchGit { url = "https://github.com/414owen/local-shellrc"; }).outPath}/source-local-shellrc.zsh"}
      ${builtins.readFile (./shell.zsh)}
      ${builtins.readFile (./fns.sh)}
      ${import ./fns.nix { pkgs = pkgs; }}
    '';
    sessionVariables = import ./env.nix { pkgs = pkgs; };
    shellAliases = aliases;
  };
}
