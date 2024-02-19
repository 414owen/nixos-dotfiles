{ pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/common.nix
    ./../../modules/graphical.nix
    ./../../modules/efi.nix
    ./../../modules/tiko.nix
    ./../../modules/no-mitigations.nix
  ];

  networking.hostName = "desktop";
  hardware.bluetooth.enable = false;
  services.openssh.enable = true;

  home-manager.users.owen = (import ../../home/home.nix {
    stateVersion = "22.11";

    imports = [
      ../../home/alacritty.nix
      ../../home/direnv.nix
      ../../home/ghci.nix
      ../../home/git.nix
      ../../home/gpg.nix
      ../../home/haskeline.nix
      ../../home/helix.nix
      ../../home/packages.nix
      ../../home/readline.nix
      ../../home/ssh.nix
      ../../home/starship.nix
      ../../home/tmux.nix
      ../../home/tiko.nix
      ../../home/zoxide.nix
      ../../home/zsh.nix

      ../../home/firefox.nix
      ../../home/foot.nix
      ../../home/theme.nix
      ../../home/gdb.nix
      ../../home/gpg-agent.nix
    ];
  });
}

