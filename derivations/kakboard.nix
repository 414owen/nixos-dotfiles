{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "kakboard";
  version = "unstable";
  src = (import ../nix/sources.nix).kakboard;
  installPhase = ''
    mkdir -p $out/share/kak/autoload
    cp *.kak $out/share/kak/autoload
  '';
}
