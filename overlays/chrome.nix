final: prev: {
  ungoogled-chromium = prev.ungoogled-chromium.override {
    commandLineArgs = toString [
      # Ungoogled features
      "--disable-search-engine-collection"
      "--extension-mime-request-handling=always-prompt-for-install"
      "--fingerprinting-canvas-image-data-noise"
      "--fingerprinting-canvas-measuretext-noise"
      "--fingerprinting-client-rects-noise"
      "--popups-to-tabs"
      "--show-avatar-button=incognito-and-guest"

      # Experimental features
      "--enable-features=${
        final.lib.concatStringsSep "," [
          "BackForwardCache:enable_same_site/true"
          "CopyLinkToText"
          "OverlayScrollbar"
          "TabHoverCardImages"
          "VaapiVideoDecoder"
          "VaapiVideoEncoder"
        ]
      }"
      "--enable-webrtc-pipewire-capturer"

      # Aesthetics
      "--force-dark-mode"
      # For chrome:// pages
      "--enable-features=WebUIDarkMode"

      # Wayland
      "--ozone-platform-hint=auto"
      "--enable-features=UseOzonePlatform"

      # Performance
      "--enable-gpu-rasterization"
      "--enable-oop-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
      "--use-vulkan"
    ];
  };
}
