# ── History ────────────────────────────────────────────────────────────────
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

export EDITOR=nvim
export VISUAL=nvim

# ── Completion styles (set before compinit) ───────────────────────────────
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-flags --preview-window=right:50%:wrap

# ── Native Zsh completion ─────────────────────────────────────────────────
autoload -Uz compinit
compinit

# ── FZF shell integration ─────────────────────────────────────────────────
# Load after compinit so fzf's completion definitions can register normally.
[[ -r "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# ── fzf-tab ────────────────────────────────────────────────────────────────
# Load after compinit and fzf's shell integration, but before other plugins
# that wrap ZLE widgets.
source "$HOME/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"

# ── zsh-sage ───────────────────────────────────────────────────────────────
source "$HOME/.zsh/plugins/zsh-sage/zsh-sage.plugin.zsh"

# Keep the existing zsh-sage acceptance bindings.
bindkey -M viins '^[[C' sage-accept
bindkey -M viins '^[OC' sage-accept
bindkey -M viins '^[[1;3C' sage-accept-word  # Option+Right on many Mac terminals
bindkey -M viins '^[f' sage-accept-word

# ── Other shell setup e.g. uv ───────────────────────────────────────────────
[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

[[ -r "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# ── Syntax highlighting (keep last among plugins) ─────────────────────────
source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
