{ stdenv, lib, fetchFromGitHub, ... }:

stdenv.mkDerivation {
  name = "kak-kakboard";
  version = "2020-11-03";

  src = fetchFromGitHub {
    owner = "lePerdu";
    repo = "kakboard";
    rev = "2f13f5cd99591b76ad5cba230815b80138825120";
    sha256 = "1kvnbsv20y09rlnyar87qr0h26i16qsq801krswvxcwhid7ijlvd";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/kak/autoload/plugins/kakboard
    cp -r kakboard.kak $out/share/kak/autoload/plugins/kakboard
  '';

  meta = with lib; {
    description = "Kakoune kakboard";
    homepage = "https://github.com/lePerdu/kakboard";
    licence = licenses.MIT;
    platform = platforms.all;
  };
}
