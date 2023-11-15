{ ... }:

{
  dconf.settings = {
    "org/gnome/epiphany/web" = {
      enable-webextensions = true;
      enable-adblock = true;
      enable-popups = false;
      enable-spell-checking = true;
      enable-itp = true;
      enable-website-data-storage = true;
      remember-passwords = true;
    };

    "org/gnome/epiphany" = {
      restore-session-policy = "crashed";
      homepage-url = "about:newtab";
      use-google-search-suggestions = false;
      ask-for-default = false;
      default-search-engine = "Google";
    };
  };
}
