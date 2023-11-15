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
      "mboxproxy-0"      = mkTikoBox "mboxproxy-0.internal";
      "mboxproxy-1"      = mkTikoBox "mboxproxy-1.internal";
      "mboxproxy-2"      = mkTikoBox "mboxproxy-2.internal";
      "sim-dev"          = mkTikoBox "simulator-be-dev";
      "hydra"            = mkTikoBox "hydra";
      "runner-1"         = mkTikoBox "nix-gitlab-runner-1.internal";
      "runner-2"         = mkTikoBox "nix-gitlab-runner-2.internal";
      "runner-3"         = mkTikoBox "nix-gitlab-runner-3.internal";
      "runner-4"         = mkTikoBox "nix-gitlab-runner-4.internal";
      "mgmt1"            = mkTikoBox "mgmt1";
      "backend1-staging" = mkTikoBox "backend1-staging.internal";
      "backend-fr-6"     = mkTikoBox "backend-fr-6.internal";
      "backend-fr-5"     = mkTikoBox "backend-fr-5.internal";
      "backend-fr-4"     = mkTikoBox "backend-fr-4.internal";
      "backend-fr-3"     = mkTikoBox "backend-fr-3.internal";
      "backend-fr-2"     = mkTikoBox "backend-fr-2.internal";
      "backend-fr-1"     = mkTikoBox "backend-fr-1.internal";
    };

    # knownHosts = {
    #   "gitlab.internal.tiko.ch" = {
    #     publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFVew5uYF6vDHk6olO3cIfLzNQ1mqrSu33Zj68k2Awd";
    #   };
    # };
  };
}
