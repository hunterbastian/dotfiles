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

# --- zoxide (smart cd: use 'z' instead of 'cd') ---
eval "$(zoxide init zsh)"

# --- zsh-autosuggestions (accept with → arrow key) ---
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Aliases ---
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias lt="eza --tree --level=2 --icons"
alias lg="lazygit"
