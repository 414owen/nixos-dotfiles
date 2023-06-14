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
        hostname = "192.168.1.26";
        user = "dietpi";
      };
      "work" = {
        hostname = "192.168.0.131";
        user = "owen";
      };
      "sim-dev"          = mkTikoBox "simulator-be-dev";
      "hydra"            = mkTikoBox "hydra";
      "runner-1"         = mkTikoBox "nix-gitlab-runner-1.internal";
      "runner-2"         = mkTikoBox "nix-gitlab-runner-2.internal";
      "runner-3"         = mkTikoBox "nix-gitlab-runner-3.internal";
      "runner-4"         = mkTikoBox "nix-gitlab-runner-4.internal";
      "mgmt1"            = mkTikoBox "mgmt1";
      "backend1-staging" = mkTikoBox "backend1-staging.internal";
      "backend-fr-6" = mkTikoBox "backend-fr-6.internal";
      "backend-fr-5" = mkTikoBox "backend-fr-5.internal";
      "backend-fr-4" = mkTikoBox "backend-fr-4.internal";
      "backend-fr-3" = mkTikoBox "backend-fr-3.internal";
      "backend-fr-2" = mkTikoBox "backend-fr-2.internal";
      "backend-fr-1" = mkTikoBox "backend-fr-1.internal";
    };
  };
}
