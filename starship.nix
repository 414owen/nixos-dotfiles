{ ... }:
{
  programs.starship = {
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      character = {
        symbol = " ^_^";
        error_symbol = " o_O";
        use_symbol_for_status = true;
        style_success = "green";
        style_failure = "red";
      };
      git_status = {
        conflicted_count = { enabled = true; };
        untracked_count = { enabled = true; };
        stashed_count = { enabled = true; };
        modified_count = { enabled = true; };
        renamed_count = { enabled = true; };
        staged_count = { enabled = true; };
        deleted_count = { enabled = true; };
      };
      aws = { disabled = true; };
      battery = { disabled = true; };
      conda = { disabled = true; };
      dotnet = { disabled = true; };
      env_var = { disabled = true; };
      golang = { disabled = true; };
      haskell = { disabled = true; };
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
