#!/bin/bash
# Symlink dotfiles into place
# Run on a fresh machine after cloning: git clone https://github.com/hunterbastian/dotfiles.git ~/.dotfiles

DOTFILES="$HOME/.dotfiles"

link() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  backing up $dst → $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sf "$src" "$dst"
  echo "  linked $dst"
}

echo "Installing dotfiles..."

# Shell
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

# Tmux
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Neovim
mkdir -p "$HOME/.config/nvim"
link "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"

# Starship (points to the active theme variant via symlink in repo)
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# Homebrew (install if missing)
if ! command -v brew &> /dev/null; then
  echo "  installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Brewfile (install all packages)
if [ -f "$DOTFILES/Brewfile" ]; then
  echo "  installing Homebrew packages..."
  brew bundle --file="$DOTFILES/Brewfile" --no-lock
fi

# Tmux Plugin Manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "  installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# npm global prefix (avoid sudo for global installs)
mkdir -p "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"

# Global npm packages
echo "  installing global npm packages..."
npm install -g vercel sass obsidian-cli playwright @memories.sh/cli @openai/codex

# Cargo packages
if command -v cargo &> /dev/null; then
  echo "  installing cargo packages..."
  cargo install trunk
fi

echo ""
echo "Done! Next steps:"
echo "  1. Restart your shell or run: source ~/.zshrc"
echo "  2. Open tmux and press Ctrl+A then I to install tmux plugins"
echo "  3. Run 'gh auth login' to authenticate GitHub"
echo "  4. Run 'vercel login' to authenticate Vercel"
echo "  5. Import an iTerm2 theme from ~/.dotfiles/iterm/"
