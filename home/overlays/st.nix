self: super: {
  st = (super.st.overrideAttrs (old: rec {
    name = "st";
    version = "0.8.3";
    src = builtins.fetchurl {
      url = "https://dl.suckless.org/st/st-0.8.3.tar.gz";
      sha256 = "0ll5wbw1szs70wdf8zy1y2ig5mfbqw2w4ls8d64r8z3y4gdf76lk";
    };
  })).override {
    extraLibs = [
    	super.harfbuzz
    ];
    patches = [
      # (builtins.fetchurl {
      #   url = "https://st.suckless.org/patches/dracula/st-dracula-0.8.2.diff";
      #   sha256 = "0zpvhjg8bzagwn19ggcdwirhwc17j23y5avcn71p74ysbwvy1f2y";
    # })
      (builtins.fetchurl {
        url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.3.diff";
        sha256 = "0n4n83mffxp8i0c2hfaqabxbqz0as2yxx8v8ll76gxiihqa1hhd2";
      })
      (builtins.fetchurl {
        url = "https://st.suckless.org/patches/ligatures/0.8.3/st-ligatures-boxdraw-20200430-0.8.3.diff";
        sha256 = "1vyx8qz3qknsw7p1c2inv7pqsw4b7x2imnysac1nc0j15hfklhfb";
      })
      # (builtins.fetchurl {
      #   url = "https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.2.diff";
      #   sha256 = "0zl12xi8i10x3i2jy4lqg64vphkx77mjp7g1rc4kdd4q8saw7psx";
      # })
      ../st-patches/desktop-entry.diff
      ../st-patches/font.diff
      ../st-patches/colors.diff
    ];
  };
}
