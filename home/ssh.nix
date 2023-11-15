{ lib, ... }:

{
  programs.ssh = {
    matchBlocks = {
      "pi" = {
        hostname = "192.168.1.26";
        user = "dietpi";
      };
    };
  };
}
