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
    bat
    cabal2nix
    cachix
    cabal-install
    unstable.duf
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
    q-text-as-data
    haskell.packages.ghc865.haskell-language-server
    htop
    imagemagick
    haskellPackages.implicit-hie
    # (import "${infra}/nix/hs-kubectl.nix")
    inkscape
    jq
    kak-lsp
    killall
    libsecret
    lshw
    mpv
    neofetch
    nix-prefetch-github
    nix-index
    nix-prefetch-git
    niv
    pciutils
    pidgin
    pidgin-window-merge
    purple-hangouts
    ranger
    rawtherapee
    remarshal
    ripgrep
    sd
    shotwell
    spotify
    stack
    zoom-us
    stdenv
    st
    tmux
    xsel
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
