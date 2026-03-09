#!/bin/bash
# Symlink dotfiles into place

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
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config/nvim"
link "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"

link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

echo "Done! Restart your shell or run: source ~/.zshrc"
