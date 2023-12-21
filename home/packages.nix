{ pkgs, ... }:

let
  lib = pkgs.lib;
  git-change-author = pkgs.writeShellScript "git-change-author" (builtins.readFile ./change-author.sh);
  scripts = import ./scripts.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    postgresql
    xh
    (pkgs.python3.withPackages (ps: with ps; [
      requests
    ]))
    any-nix-shell
    asciinema
    bat
    bfs
    cabal2nix
    cabal-install
    cachix
    calibre
    cgdb
    choose
    coreutils
    darktable
    dateutils
    diskonaut
    dua
    duf
    editorconfig-core-c
    evince
    eza
    expect
    file
    fira
    fira-code
    fira-mono
    font-awesome
    gdb
    ghc
    gimp
    gitAndTools.hub
    git-crypt
    gnome3.geary
    gnome.devhelp
    gnomeExtensions.material-shell
    gnomeExtensions.system-monitor
    gnumake
    gnumeric
    gnupg
    gotop
    gparted
    helix
    htop
    hub
    imagemagick
    inkscape
    jetbrains-mono
    jq
    killall
    libsecret
    lshw
    macchina
    mosh
    mpv
    neofetch
    niv
    nix-bundle
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nix-prefetch-github
    nnn
    non
    pciutils
    pidgin
    # prismlauncher
    q-text-as-data
    remarshal
    # retroarchFull
    ripgrep
    scripts.copy
    sd
    # shotwell
    signal-desktop
    spot
    spotify
    stdenv
    tmux
    transmission-gtk
    tree
    tup
    chromium
    usbutils
    vault
    vlc
    wine
    wl-clipboard
    xclip
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
    scripts.git-weekend
  ]);
}
