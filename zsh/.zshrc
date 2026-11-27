# History
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# explicitly set viins
bindkey -v

export EDITOR=nvim
export VISUAL=nvim

# ── Plugins (order matters!) ──────────────────────────
# 1. zsh-autocomplete (runs compinit internally)
source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# 2. zsh-sage (replaces zsh-autosuggestions)
source ~/.zsh/plugins/zsh-sage/zsh-sage.plugin.zsh

# 3. zsh-syntax-highlighting (MUST be last)
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# uv
. "$HOME/.local/bin/env"

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases   

# Set up fzf key bindings and fuzzy completion
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# ── fzf-tab (after fzf; before custom bindkeys) ──
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-flags --preview-window=right:50%:wrap
# Adjust path to your install:
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
# Autocomplete's first prompt removes fzf-tab's completion hook. Put it back after that.
fzf-tab-after-autocomplete() {
  add-zsh-hook -d precmd fzf-tab-after-autocomplete

  # Drop the startup wrap that captured fzf-completion.
  disable-fzf-tab
  unfunction _main_complete
  autoload -Uz _main_complete

  # Now enable, so it wraps the real completer and not fzf-completion.
  bindkey -M emacs '^I' expand-or-complete
  bindkey -M viins '^I' expand-or-complete
  enable-fzf-tab

  # **<Tab> falls back to ordinary completion, never back into fzf-tab.
  fzf_default_completion=expand-or-complete

  tab-with-fzf() {
    if [[ $LBUFFER == *'**' ]]; then
      zle fzf-completion
      return
    fi
    zle fzf-tab-complete
  }
  # Arrow-down must not enter autocomplete's menu, or Tab stays menu-complete.
  bindkey -M viins '^[[B' down-line-or-history
  bindkey -M viins '^[OB' down-line-or-history
  bindkey -M emacs '^[[B' down-line-or-history
  bindkey -M emacs '^[OB' down-line-or-history

  zle -N tab-with-fzf
  bindkey -M emacs '^I' tab-with-fzf
  bindkey -M viins '^I' tab-with-fzf
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd fzf-tab-after-autocomplete

# ── After fzf: sage accept in vi insert (tmux: both arrow sequences) ──
bindkey -M viins '^[[C' sage-accept
bindkey -M viins '^[OC' sage-accept
bindkey -M viins '^[[1;3C' sage-accept-word  # Option+Right on many Mac terminals
bindkey -M viins '^[f' sage-accept-word
