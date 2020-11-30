{ pkgs, ... }:

let
  lib = pkgs.lib;
  unstable = import <unstable> { config = { allowUnfree = true; }; };
  # infra = builtins.fetchGit {
  #   url = "https://git.hubteam.com/HubSpot/piesync-infra";
  # };
in
{
  home.packages = with pkgs; [
    any-nix-shell
    asciinema
    bat
    discord
    cabal2nix
    cabal-install
    cachix
    calibre
    darktable
    discord
    exa
    fasd
    fd
    firefox
    ghc
    gimp
    gitAndTools.hub
    gnome3.geary
    gnome3.gnome-tweaks
    gnumeric
    gnupg
    gparted
    haskell.packages.ghc865.haskell-language-server
    haskellPackages.implicit-hie
    haskellPackages.retrie
    htop
    imagemagick
    inkscape
    jq
    kak-lsp
    killall
    libsecret
    lshw
    mpv
    multimc
    neofetch
    (netsurf.browser.override { uilib = "gtk"; })
    niv
    nix-index
    nix-prefetch-git
    nix-prefetch-github
    pciutils
    pidgin
    pidgin-window-merge
    purple-hangouts
    q-text-as-data
    ranger
    rawtherapee
    remarshal
    ripgrep
    sd
    shotwell
    spotify
    st
    stdenv
    tmux
    transmission-gtk
    unstable.duf
    xsel
    zoom-us
    zsh-history-substring-search
    zsh-syntax-highlighting
  ] ++ (with gitAndTools; [
    gh
    git-absorb
    git-gone
    git-open
    git-recent
    git-standup
    git-test
    git-fame
  ]);
}
