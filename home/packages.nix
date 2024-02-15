{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    alacritty
    xh
    any-nix-shell
    bat
    bzip2
    cabal2nix
    cabal-install
    cachix
    coreutils
    dateutils
    exa
    fd
    file
    ghc
    helix
    htop
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
  ]);
}
