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
    };
    # knownHosts = {
    #  "gitlab.internal.tiko.ch" = {
    #     publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFVew5uYF6vDHk6olO3cIfLzNQ1mqrSu33Zj68k2Awd";
    #   };
    # };
  };
}
