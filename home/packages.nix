{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    lean4

    xh
    any-nix-shell
    bat
    bzip2
    cabal2nix
    cabal-install
    cachix
    coreutils
    dateutils
    eza
    fd
    file
    ghc
    git-crypt
    helix
    htop
    hub
    # some systems *cough* darwin *cough* don't have terminfo for tmux
    ncurses
    jq
    niv
    nix-output-monitor
    nurl
    ripgrep
    sd
    stdenv
    tmux
  ] ++ (with gitAndTools; [
    git-absorb
    git-gone
    # Requires pandoc
    # git-open
    # Requires util-linux
    # git-recent
    git-standup
    git-test
    git-fame
    scripts.git-weekend
  ] ++ (if pkgs.stdenv.isLinux then [
    spotify
    spot
    chromium
  ] else []));
}
