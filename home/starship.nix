{ pkgs, ... }:

let
  syms = {
    "aws" = {
      symbol = "  ";
    };

    "buf" = {
      symbol = " ";
    };

    "c" = {
      symbol = " ";
    };

    "conda" = {
      symbol = " ";
    };

    "dart" = {
      symbol = " ";
    };

    "directory" = {
      read_only = " ";
    };

    "docker_context" = {
      symbol = " ";
    };

    "elixir" = {
      symbol = " ";
    };

    "elm" = {
      symbol = " ";
    };

    "git_branch" = {
      symbol = " ";
    };

    "golang" = {
      symbol = " ";
    };

    "guix_shell" = {
      symbol = " ";
    };

    "haskell" = {
      symbol = " ";
    };

    "haxe" = {
      symbol = "⌘ ";
    };

    "hg_branch" = {
      symbol = " ";
    };

    "java" = {
      symbol = " ";
    };

    "julia" = {
      symbol = " ";
    };

    "lua" = {
      symbol = " ";
    };

    "memory_usage" = {
      symbol = " ";
    };

    "meson" = {
      symbol = "喝 ";
    };

    "nim" = {
      symbol = " ";
    };

    "nix_shell" = {
      symbol = " ";
    };

    "nodejs" = {
      symbol = " ";
    };

    os.symbols = {
      Alpine = " ";
      Amazon = " ";
      Android = " ";
      Arch = " ";
      CentOS = " ";
      Debian = " ";
      DragonFly = " ";
      Emscripten = " ";
      EndeavourOS = " ";
      Fedora = " ";
      FreeBSD = " ";
      Garuda = "﯑ ";
      Gentoo = " ";
      HardenedBSD = "ﲊ ";
      Illumos = " ";
      Linux = " ";
      Macos = " ";
      Manjaro = " ";
      Mariner = " ";
      MidnightBSD = " ";
      Mint = " ";
      NetBSD = " ";
      NixOS = " ";
      OpenBSD = " ";
      OracleLinux = " ";
      Pop = " ";
      Raspbian = " ";
      RedHatEnterprise = " ";
      Redhat = " ";
      Redox = " ";
      SUSE = " ";
      Solus = "ﴱ ";
      Ubuntu = " ";
      Unknown = " ";
      Windows = " ";
      openSUSE = " ";
    };

    "package" = {
      symbol = " ";
    };

    "python" = {
      symbol = " ";
    };

    "rlang" = {
      symbol = "ﳒ ";
    };

    "ruby" = {
      symbol = " ";
    };

    "rust" = {
      symbol = " ";
    };

    "scala" = {
      symbol = " ";
    };

    "spack" = {
      symbol = "🅢 ";
    };
  };
in

{
  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
    enableNushellIntegration = true;
    settings = syms // {
      character = {
        success_symbol = " [^_^](green)";
        error_symbol = " [o_O](red)";
        # use_symbol_for_status = true;
      };
      aws = { disabled = true; };
      battery = { disabled = true; };
      conda = { disabled = true; };
      dotnet = { disabled = true; };
      env_var = { disabled = true; };
      golang = { disabled = true; };
      # haskell = { disabled = true; };
      hg_branch = { disabled = true; };
      java = { disabled = true; };
      memory_usage = { disabled = true; };
      nodejs = { disabled = true; };
      php = { disabled = true; };
      python = { disabled = true; };
      ruby = { disabled = false; };
      terraform = { disabled = true; };
    };
  };
}
