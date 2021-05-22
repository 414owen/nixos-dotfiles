{ pkgs, ... }:

let
  lib = pkgs.lib;
  unstable = import <unstable> { config = { allowUnfree = true; }; };
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
    unstable.macchina
    nnn
    niv
    nix-index
    unstable.nix-output-monitor
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
    unstable.duf
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
