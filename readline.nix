{ ... }:
{
  programs.readline = {
    variables = {
      # Show filetype in completions by colorisation
      colored-stats = true;

      # Ignore case
      completion-ignore-case = true;

      # If the completion and the typed string share a prefix longer than three
      # characters, replace it with '___'
      completion-prefix-display-length = 3;

      # VI mode is always best
      editing-mode = "vi";

      # Display a '\' after symlinks
      mark-symlinked-directories = true;

      # Autofill completions until ambiguous, and show all, if autocomplete called
      # again, start cycling through suffixes
      show-all-if-ambiguous = true;
      show-all-if-unmodified = true;
      menu-complete-display-prefix = true;

      # Show filetype in completions by appending a char
      visible-stats = true;


      ###
      # Insert mode bindings
      ###

      keymap = "vi-insert";
    };

    bindings = {

      # Clear screen
      "\\C-l" = "clear-screen";

      # Use tab to expand globs and menu complete
      "\\C-g" = "glob-expand-word";

      # Cycle through completions with tab
      "\\t" = "menu-complete";

      # Movement
      "\\C-a" = "beginning-of-line";
      "\\C-e" = "end-of-line";

      # Move back/worward by word in insertion mode
      "\\C-b" = "backward-word";
      "\\C-f" = "forward-word";

      # Search history using up and down arrows, with current line as search prefix
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";

      # Yank last argument
      "\\C-." = "yank-nth-arg";

      # Delete Key
      "^[[3~" = "delete-char";
    };
  };
}
