{ pkgs, ... }:

let
  delta = pkgs.gitAndTools.delta;
  base-log = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) -";
  common = import ./common.nix;
in

{
  programs.git = {
    enable = true;
    aliases = {
      lg1 = "${base-log} %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      lg2 = "${base-log} %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      lg = "lg1";
      pl = "!git pull $(git remote) $(git branch --show-current)";
      up = "!git branch --set-upstream-to=$(git remote)/$(git branch --show-current) $(git branch --show-current)";
      yeet = "!git clean -dfx; git reset --hard; git submodule update --init";
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
        pager = "${delta}/bin/delta --side-by-side";
      };
      interactive = {
        diffFilter = "${delta}/bin/delta --color-only --side-by-side";
      };
      hub = {
        protocol = "https";
      };
      branch = {
        autoSetupMerge = "always";
      };
      merge = {
        conflictstyle = "diff3";
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      url = {
        "https://github.com/" = {
          insteadOf = "git://github.com/";
        };
      };
    };
  };
}
