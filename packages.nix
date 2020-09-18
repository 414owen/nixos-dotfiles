{ pkgs, ... }:

let
  lib = pkgs.lib;
  unstable = import <unstable> { config = { allowUnfree = true; }; };
  infra = builtins.fetchGit {
    url = "https://git.hubteam.com/HubSpot/piesync-infra";
  };
in
{
  home.packages = with pkgs; [
    any-nix-shell
    bat
    cabal2nix
    cachix
    cabal-install
    darktable
    unstable.ungoogled-chromium
    exa
    fasd
    fd
    firefox
    unstable.ghc
    gimp
    gitAndTools.hub
    gparted
    gnome3.geary
    gnome3.gnome-tweaks
    gnupg
    unstable.haskell.packages.ghc865.haskell-language-server
    htop
    imagemagick
    unstable.haskellPackages.implicit-hie
    (import "${infra}/nix/hs-kubectl.nix")
    inkscape
    jq
    kakoune
    kak-lsp
    killall
    libsecret
    lshw
    mpv
    neofetch
    nix-prefetch-github
    nix-index
    nix-prefetch-git
    nixops
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
    unstable.stack
    unstable.zoom-us
    stdenv
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
