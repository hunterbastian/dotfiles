# --- Path ---
export PATH="$(npm prefix -g)/bin:$PATH"
. "$HOME/.local/bin/env"
export PATH="$(npm config get prefix)/bin:$PATH"

# --- Secrets (macOS Keychain) ---
export OPENAI_API_KEY=$(security find-generic-password -a "$USER" -s "OPENAI_API_KEY" -w)

# --- Starship prompt ---
eval "$(starship init zsh)"

# --- fzf (fuzzy finder: Ctrl+R for history, Ctrl+T for files) ---
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="
  --color=bg+:#282726,bg:#100F0F,fg:#CECDC3,fg+:#FFFCF0
  --color=hl:#4385BE,hl+:#4385BE,info:#878580,marker:#66800B
  --color=prompt:#AF3029,spinner:#A02F6F,pointer:#A02F6F,header:#4385BE
  --color=border:#282726,separator:#282726
  --border=rounded --padding=1 --prompt='❯ ' --pointer='▌'
"

# --- zoxide (smart cd: use 'z' instead of 'cd') ---
eval "$(zoxide init zsh)"

# --- zsh-autosuggestions (accept with → arrow key) ---
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- zsh-syntax-highlighting (colors commands as you type) ---
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- bat (syntax-highlighted cat) ---
export BAT_THEME="base16"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"

# --- Aliases ---
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias lt="eza --tree --level=2 --icons"
alias lg="lazygit"
alias cat="bat --paging=never"

# --- Clipboard image → file path (for pasting images into Claude Code) ---
cpimg() {
  local f="/tmp/clipboard-$(date +%s).png"
  pngpaste "$f" 2>/dev/null && echo "$f" | pbcopy && echo "Copied path: $f" || echo "No image in clipboard"
}

# --- Fastfetch on new tab ---
fastfetch

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

