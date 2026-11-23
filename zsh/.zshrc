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
#. <(fzf --zsh)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh



# fzf commands
#export FZF_DEFAULT_OPTS="
#  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && tree -C {} | head -50)'
#  --bind '?:toggle-preview'
#  --preview-window right:60% --walker=file,follow,hidden --walker-skip=.git,node_modules,target,dist"
#export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"   
# export FZF_ALT_C_OPTS="--walker-skip .git,node_modules,Library,Applications,Music,Pictures,Movies"

#export FZF_DEFAULT_OPTS="
 # --preview 'bat --color=always --style=numbers --line-range :300 {}'
 # --preview-window right:60%,border-left
 # --bind 'ctrl-/:change-preview-window(down|hidden|)'
 # --bind 'ctrl-u:preview-page-up'
 # --bind 'ctrl-d:preview-page-down'
 # --bind 'ctrl-b:preview-top'
 # --bind 'ctrl-e:preview-bottom'"   

#export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --exclude node_modules --exclude dist --exclude target'
#export FZF_DEFAULT_OPTS="
#  --height=60%
#  --layout=reverse
#  --border=rounded
#  --margin=1
#  --info=inline
#  --bind='ctrl-/:toggle-preview'
#"
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git --exclude node_modules --exclude dist --exclude target'




