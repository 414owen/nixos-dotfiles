{ lib, ... }:

let
  mkTikoBox = prefix: {
    hostname = prefix + ".tiko.ch";
    identityFile = "~/.ssh/aws-prod-keypair.pem";
    user = "root";
    extraOptions = {
      preferredAuthentications = "publickey";
    };
  };
in

{
  programs.ssh = {
    matchBlocks = {
      "vps" = {
        hostname = "185.164.136.123";
        user = "owen";
      };
      "pi" = {
        hostname = "192.168.0.241";
        user = "pi";
      };
      "work" = {
        hostname = "192.168.0.131";
        user = "owen";
      };
      "hydra"    = mkTikoBox "hydra";
      "runner-1" = mkTikoBox "nix-gitlab-runner-1.internal";
      "runner-2" = mkTikoBox "nix-gitlab-runner-2.internal";
      "runner-3" = mkTikoBox "nix-gitlab-runner-3.internal";
      "runner-4" = mkTikoBox "nix-gitlab-runner-4.internal";
      "mgmt1"    = mkTikoBox "mgmt1";
    };
  };
}
