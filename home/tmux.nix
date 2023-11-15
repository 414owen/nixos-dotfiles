{ pkgs, ... }:
let
  scripts = import ./scripts.nix { inherit pkgs; };
in

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = ''
      ${builtins.readFile ./tmux.conf}
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe "${scripts.copy}"
      bind-key -T copy-mode-vi y send-keys -X copy-pipe "${scripts.copy}"
    '';
  };
}
