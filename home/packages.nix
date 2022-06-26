{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
  unstable = import <unstable> {};
  sources = import ./nix/sources.nix;
in
{
  home.packages = with pkgs; [
    any-nix-shell
    asciinema
    bat
    chromium
    choose
    cabal2nix
    cabal-install
    cachix
    calibre
    coreutils
    dateutils
    editorconfig-core-c
    fira
    fira-mono
    font-awesome
    gnome.devhelp
    evince
    spot
    exa
    expect
    file
    fd
    gnupg
    gnomeExtensions.system-monitor
    ghc
    htop
    gnumake
    cgdb
    ghc
    gimp
    gitAndTools.hub
    unstable.helix
    htop
    imagemagick
    inkscape
    jq
    killall
    libsecret
    libreoffice-fresh
    btop
    lshw
    macchina
    mosh
    mpv
    neofetch
    nix-bundle
    nnn
    niv
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-prefetch-github
    nnn
    pciutils
    pidgin
    q-text-as-data
    remarshal
    ripgrep
    sd
    stdenv
    xclip
    scripts.copy
    scripts.vpn
    wl-clipboard
    tree
    tmux
    tree
    usbutils
    duf
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
    scripts.git-weekend
  ]);
}