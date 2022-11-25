{ ... }:
{
  programs.starship = {
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    # enableNushellIntegration = true;
    settings = {
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
