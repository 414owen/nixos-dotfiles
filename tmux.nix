{ ... }:
{
  programs.tmux = {
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
