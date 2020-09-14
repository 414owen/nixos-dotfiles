{ pkgs, home, ... }:

let common = import ./common.nix;
in

{
  home.file.".stack/config.yaml" = {
    text = ''
      templates:
        params:
         author-name: ${common.name}
         author-email: ${common.email}
         github-username: 414owen

      ghc-options:
          "$everything": -j2
    '';
  };
}
