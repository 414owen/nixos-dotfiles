{ pkgs, ... }:

let
  gitAndTools = pkgs.gitAndTools;
  delta = gitAndTools.delta;
  base-log = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -";
in

{
  programs.git = {
    aliases = {
      lg1 = "${base-log} %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      lg2 = "${base-log} %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      lg = "lg1";
    };
    ignores = [
      "dist/"
      "dist-newstyle/"
      "ignore"
      ".local.sh"
      "result/"
      ".stack-work/"
      "stack.yaml.lock"
      "tags"
      "TAGS"
      ".c-lang-serv"
    ];
    userName  = "Owen Shepherd";
    userEmail = "owen@owen.cafe";
     signing = {
      key = "owen@owen.cafe";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        pager = "${delta}/bin/delta --plus-color='#226522'";
      };
      hub = {
        protocol = "https";
      };
      interactive = {
        diffFilter = "${delta}/bin/delta";
      };
    };
  };
}
