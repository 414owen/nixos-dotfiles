# macchina

export HISTCONTROL=ignoreboth:erasedups

function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^[[3~" delete-char
