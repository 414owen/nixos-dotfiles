# https://www.tweag.io/blog/2020-07-31-nixos-flakes/

# To switch from channels to flakes execute:
# cd /etc/nixos
# sudo wget -O flake.nix https://gist.githubusercontent.com/misuzu/80af74212ba76d03f6a7a6f2e8ae1620/raw/flake.nix
# sudo git init
# sudo git add . # won't work without this
# nix-shell -p nixFlakes --run "sudo nix --experimental-features 'flakes nix-command' build .#nixosConfigurations.$(hostname).config.system.build.toplevel"
# sudo ./result/bin/switch-to-configuration switch

# Now nixos-rebuild can use flakes:
# sudo nixos-rebuild switch --flake /etc/nixos

# To update flake.lock run:
# sudo nix flake update --commit-lock-file /etc/nixos

{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  inputs.home-manager.url = "github:nix-community/home-manager/release-23.05";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      systemMapper = system: { name = system.config.networking.hostName; value = system; };
    in
    {
      nixosConfigurations = builtins.listToAttrs (builtins.map systemMapper
      [
        (nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # Things in this set are passed to modules and accessible
          # in the top-level arguments (e.g. `{ pkgs, lib, inputs, ... }:`).
          specialArgs = {
            inherit self;
          };
          modules = [
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.dell-xps-13-9380
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-cpu-amd

            ({ pkgs, ... }: {
              environment.etc."nix/channels/nixpkgs".source = nixpkgs.outPath;
              environment.etc."nix/channels/home-manager".source = home-manager.outPath;

              nix.nixPath = [ 
                "nixpkgs=/etc/nix/channels/nixpkgs"
                "home-manager=/etc/nix/channels/home-manager"
              ];

              nix.settings.experimental-features = "nix-command flakes";

              home-manager.useGlobalPkgs = true;
            })

            ./configuration.nix
          ];
        })
      ]
    );
  };
}
