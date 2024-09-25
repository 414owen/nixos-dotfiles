{ self, pkgs, nix-std, ... }: {
  imports = [
    ../../modules/yabai.nix
    ../../modules/skhd.nix
    ../../modules/fonts-darwin.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.helix
      pkgs.gitMinimal
    ];

  environment.postBuild = ''
    ln -sv ${pkgs.path} $out/nixpkgs
  '';

  # TODO extract this out to its own module
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.owen = (import ./../../home/home.nix {
    stateVersion = "23.11";
    imports = [
      ../../home/add-mac-apps.nix
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
      ../../home/zoxide.nix
      ../../home/zsh.nix
    ];
    targets.darwin.defaults.NSGlobalDomain.AppleLocale = "en_GB";
  });
  home-manager.extraSpecialArgs = {
    inherit nix-std;
  };

  users.users.owen = {
    home = "/Users/owen";
  };


  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    linux-builder = {
      enable = false;
      ephemeral = true;
      package = pkgs.darwin.linux-builder;
    };
    nixPath = [ 
      "nixpkgs=/run/current-system/sw/nixpkgs"
    ];
    # Necessary for using flakes on this system.
    settings = {
      trusted-users = [ "@admin" ];
      experimental-features = "nix-command flakes";
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
