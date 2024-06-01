{ pkgs, ...}:

let 
  enableZsh = { enable = true; enableZshIntegration = true; };
in

{
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

  home-manager.users.owen = {
    imports = [
        ../../home/alacritty.nix
        ../../home/direnv.nix
        ../../home/ghci.nix
        ../../home/git.nix
        ../../home/gpg.nix
        ../../home/haskeline.nix
        ../../home/helix.nix
        ../../home/packages.nix
        ../../home/packages-linux.nix
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

    # TODO reenable
    manual.manpages.enable = false;

    home = {
      stateVersion = "22.11";
      packages = with pkgs; [
        any-nix-shell
      ];
      username = "owen";
      sessionVariables = import ../../home/env.nix { pkgs = pkgs; };
      homeDirectory = "/home/owen";
      keyboard = {
        layout = "gb";
        options = [
          "ctrl:swapcaps"
        ];
      };
    };

    programs = {
      command-not-found.enable = true;
      dircolors = enableZsh;
      fzf = enableZsh;
      home-manager.enable = true;
    };

    nixpkgs.config.allowUnfree = true;
  };
}

