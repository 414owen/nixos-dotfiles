self: { alsaLib, patchelf, freetype, curlFull, libGL, xorg, stdenv, lib, dpkg, glibc, autoPatchelfHook, ... }: {
  waveform-pro = let

      # Please keep the version x.y.0.z and do not update to x.y.76.z because the
      # source of the latter disappears much faster.
      version = "12.0.0";

      src = builtins.fetchurl {
        url = "https://cdn.tracktion.com/file/tracktiondownload/waveform/1110/waveform_64bit_v11.1.0.deb";
        sha256 = "1a3yklgbfyi0dpq84qvwwl9appjskml3kdqhnvbrjjnjxddmlahg";
      };

    in
    stdenv.mkDerivation {
      name = "waveform-${version}";

      # system = "x86_64-linux";

      inherit src;

      # Required for compilation
      nativeBuildInputs = [
        autoPatchelfHook # Automatically setup the loader, and do the magic
        patchelf
        dpkg
      ];

      # Required at running time
      buildInputs = [
        # glibc
        # gcc-unwrapped
        alsaLib
        freetype
        xorg.libX11
        xorg.libXext
        libGL
        curlFull
      ];
      curl = curlFull;

      unpackPhase = "true";

      # Extract and copy executable in $out/bin
      installPhase = ''
        mkdir -p $out/bin
        dpkg -x $src $out
        mv $out/usr/bin/Waveform11 $out/bin/Waveform11
      '';

      postFixup = ''
        # patchelf --set-rpath ${curlFull}/lib $out/bin/Waveform11
        patchelf --add-needed libcurl.so.4 $out/bin/Waveform11
      '';

      meta = with lib; {
        description = "Tracktion Waveform Pro";
        homepage = https://www.tracktion.com/products/waveform-pro;
        license = licenses.unfree;
        maintainers = with stdenv.lib.maintainers; [ ];
        platforms = [ "x86_64-linux" ];
      };
    };
}
