{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    any-nix-shell
    asciinema
    bat
    brave
    cachix
    dateutils
    exa
    expect
    fd
    fira
    fira-mono
    gnupg
    htop
    imagemagick
    jq
    kak-lsp
    killall
    libsecret
    lshw
    macchina
    nnn
    niv
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-prefetch-github
    pciutils
    q-text-as-data
    remarshal
    ripgrep
    sd
    spotify
    stdenv
    tmate
    tmux
    usbutils
    duf
    xsel
    zsh-history-substring-search
    zsh-syntax-highlighting
  ] ++ (with gitAndTools; [
    gh
    git-absorb
    # git-change-author
    git-gone
    git-open
    git-recent
    git-standup
    git-test
    git-fame
  ]);
}
