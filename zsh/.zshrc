# History
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE


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

