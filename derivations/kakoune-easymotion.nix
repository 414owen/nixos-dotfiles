{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "kakoune-easymotion";
  version = "unstable";
  src = (import ../nix/sources.nix).kakoune-easymotion;
  installPhase = ''
    mkdir -p $out/share/kak/autoload
    cp *.kak $out/share/kak/autoload
  '';
}
