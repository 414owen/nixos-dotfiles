{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 180000;
    defaultCacheTtlSsh = 180000;
  };
}
