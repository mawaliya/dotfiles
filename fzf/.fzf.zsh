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
  file=$(fzf) && ${EDITOR:-vim} "$file"
}

gch() {
  local branch
  branch=$(git branch --all | grep -v HEAD | sed 's/.* //' | sed 's#remotes/origin/##' | sort -u | fzf) && git checkout "$branch"
}

# Live interactive ripgrep + fzf search -> preview highlighted line -> open in vim
# Usage: rfg [optional initial query]
# WARNING: NOT PERFORMANT YET. TO FIX!
rfg() {
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  local INITIAL_QUERY="${*:-}"

  fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+clear-query+rebind(ctrl-r)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)" \
      --prompt '1. ripgrep> ' \
      --delimiter : \
      --header 'CTRL-R: ripgrep mode | CTRL-F: fuzzy filter results | ENTER: open in vim' \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(vim {1} +{2})'
}


# Catppuccin Mocha palette + layout options
export FZF_DEFAULT_OPTS="
  --height=60%
  --layout=reverse
  --border=rounded
  --margin=1
  --info=inline
  --preview '
    if [ -d {} ]; then
      eza --tree --color=always {} | head -200
    elif [ -f {} ]; then
      if file --mime-type {} | grep -qE \"text/|application/json|application/xml|application/javascript|inode/x-empty\"; then
        bat --color=always --style=numbers --line-range :300 {}
      else
        echo \"Binary/Non-text file:\" && file -b {}
      fi
    else
      echo {}
    fi
  '
  --preview-window right:60%,border-left
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --bind 'ctrl-u:preview-page-up'
  --bind 'ctrl-d:preview-page-down'
  --bind 'ctrl-b:preview-top'
  --bind 'ctrl-e:preview-bottom'
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --color=selected-bg:#45475a,border:#6c7086,label:#cdd6f4
"

# Scoped previews & macOS pbcopy support
export BAT_THEME="Catppuccin Mocha"
export FZF_CTRL_R_OPTS="
  --preview 'echo {2..} | bat --color=always -pl zsh'
  --preview-window down:40%:wrap:border-top
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'CTRL-Y: Copy command | CTRL-/: Toggle preview'
"
