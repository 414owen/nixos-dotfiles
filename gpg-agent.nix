{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 180000;
    defaultCacheTtlSsh = 180000;
    # pinentryFlavor = "gnome3";
    extraConfig = "pinentry-program ${pkgs.pinentry.gnome3}/bin/pinentry";
  };
}
