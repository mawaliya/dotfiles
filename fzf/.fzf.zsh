# Load fzf Zsh keybindings and fuzzy completion
source <(fzf --zsh)

# Use fd for fast file and directory lookups
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'

# Zsh fuzzy path completion (**<Tab>) using fd
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

fe() {
  local file
  file=$(fzf --preview 'bat {} --style=numbers --color=always') && ${EDITOR:-vim} "$file"
}

gch() {
  local branch
  branch=$(git branch --all | grep -v HEAD | sed 's/.* //' | sed 's#remotes/origin/##' | sort -u | fzf) && git checkout "$branch"
}

# Catppuccin Mocha palette + layout options
export FZF_DEFAULT_OPTS="
  --height=60%
  --layout=reverse
  --border=rounded
  --margin=1
  --info=inline
  --bind='ctrl-/:toggle-preview,ctrl-_:toggle-preview'
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --color=selected-bg:#45475a,border:#6c7086,label:#cdd6f4
"

# Scoped previews & macOS pbcopy support
export BAT_THEME="Catppuccin Mocha"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'Press CTRL-Y to copy command'
"

