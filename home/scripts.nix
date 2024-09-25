{ pkgs, ... }:

let
  writeScript = pkgs.writeShellScriptBin;
  git-weekend = writeScript "git-weekend" ''
    FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch --env-filter 'at="$(git log --no-walk --pretty=format:%ai $GIT_COMMIT)" \
        ct="$(git log --no-walk --pretty=format:%ci $GIT_COMMIT)"; \
        export GIT_AUTHOR_DATE=$(date -d "$(dateround "$at" Sat)" "+%Y-%m-%d %H:%M:%S") \
        GIT_COMMITTER_DATE=$(date -d "$(dateround "$ct" Sat)" "+%Y-%m-%d %H:%M:%S")'
  '';
  copy = writeScript "copy" ''
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      wl-copy $@
    elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
      xclip -selection clipboard $@
    else
      echo "Can't copy. Please set XDG_SESSION_TYPE." >&2
    fi
  '';
in

{
  inherit copy;
  inherit git-weekend;
}
