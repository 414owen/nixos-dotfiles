{ lib, ... }:

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
      "hydra" = {
        hostname = "hydra.tiko.ch";
        identityFile = "~/.ssh/aws-prod-keypair.pem";
        user = "root";
        extraOptions = {
          preferredAuthentications = "publickey";
        };
      };
      "runner-1" = {
        hostname = "nix-gitlab-runner-1.internal.tiko.ch";
        identityFile = "~/.ssh/aws-prod-keypair.pem";
        user = "root";
        extraOptions = {
          preferredAuthentications = "publickey";
        };
      };
      "runner-2" = {
        hostname = "nix-gitlab-runner-2.internal.tiko.ch";
        identityFile = "~/.ssh/aws-prod-keypair.pem";
        user = "root";
        extraOptions = {
          preferredAuthentications = "publickey";
        };
      };
      "runner-3" = {
        hostname = "nix-gitlab-runner-3.internal.tiko.ch";
        identityFile = "~/.ssh/aws-prod-keypair.pem";
        user = "root";
        extraOptions = {
          preferredAuthentications = "publickey";
        };
      };
      "runner-4" = {
        hostname = "nix-gitlab-runner-4.internal.tiko.ch";
        identityFile = "~/.ssh/aws-prod-keypair.pem";
        user = "root";
        extraOptions = {
          preferredAuthentications = "publickey";
        };
      };
    };
  };
}
