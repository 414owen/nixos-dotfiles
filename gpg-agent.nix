{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 180000;
    defaultCacheTtlSsh = 180000;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry.tty}/bin/pinentry-tty
      allow-loopback-pinentry
    '';
  };
}
