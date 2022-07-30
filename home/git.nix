{ pkgs, ... }:

let
  delta = pkgs.gitAndTools.delta;
  base-log = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -";
  common = import ./common.nix;
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
    userName  = common.name;
    userEmail = common.email;
     signing = {
      key = common.email;
      signByDefault = true;
    };
    extraConfig = {
      core = {
        pager = "${delta}/bin/delta --plus-style='#226522'";
      };
      interactive = {
        diffFilter = "${delta}/bin/delta --color-only";
      };
      hub = {
        protocol = "https";
      };
      push = {
        default = "current";
      };
      merge = {
        conflictstyle = "diff3";
      };
      url = {
        "https://github.com/" = {
          insteadOf = "git://github.com/";
        };
      };
    };
  };
}
