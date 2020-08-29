{ ... }:

let
  nixDirenv = (
    builtins.fetchGit {
      url = https://github.com/nix-community/nix-direnv;
      rev = "f8da3dcb49c1459de8bb300cac10f06a5add5d9b";
    }
  );
in

{
  programs.direnv = {
    enableZshIntegration = true;
    stdlib = ''
      source ${nixDirenv}/direnvrc;
    '';
  };
}
