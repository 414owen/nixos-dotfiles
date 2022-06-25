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
  };
}
