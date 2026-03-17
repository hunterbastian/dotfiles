# --- Auto-start tmux (disabled — using iTerm2 session restoration instead) ---
# if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [[ ! "$TERM_PROGRAM" =~ ^(vscode|cursor)$ ]]; then
#   tmux new-session -A -s main
# fi

# --- Path ---
export PATH="$(npm prefix -g)/bin:$PATH"
. "$HOME/.local/bin/env"
export PATH="$(npm config get prefix)/bin:$PATH"

# --- Secrets (macOS Keychain) ---
export OPENAI_API_KEY=$(security find-generic-password -a "$USER" -s "OPENAI_API_KEY" -w)

# --- Theme (swap to theme-tokyo-night.zsh to switch) ---
source "$HOME/.dotfiles/zsh/theme-tokyo-night.zsh"

# --- Starship prompt ---
eval "$(starship init zsh)"

# --- fzf (fuzzy finder: Ctrl+R for history, Ctrl+T for files) ---
source <(fzf --zsh)

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
alias claude="claude --remote-control"
alias cat="bat --paging=never"

# --- Theme switcher: `theme flexoki` or `theme tokyo-night` ---
theme() {
  local name="${1:-}"
  if [[ -z "$name" ]]; then
    echo "Usage: theme <flexoki|tokyo-night>"
    echo "Current: $(basename "$(readlink ~/.dotfiles/starship/starship.toml)" .toml | sed 's/starship-//')"
    return 0
  fi
  if [[ ! -f "$HOME/.dotfiles/zsh/theme-${name}.zsh" ]]; then
    echo "Unknown theme: $name"
    return 1
  fi
  # Update zshrc theme source
  sed -i '' "s|theme-.*\.zsh|theme-${name}.zsh|" "$HOME/.dotfiles/zsh/.zshrc"
  # Swap starship config
  ln -sf "$HOME/.dotfiles/starship/starship-${name}.toml" "$HOME/.dotfiles/starship/starship.toml"
  # Swap tmux theme
  sed -i '' "s|tmux-.*\.conf|tmux-${name}.conf|" "$HOME/.dotfiles/tmux/.tmux.conf"
  # Reload tmux if running
  [ -n "$TMUX" ] && tmux source-file ~/.tmux.conf 2>/dev/null
  # Re-source shell theme
  source "$HOME/.dotfiles/zsh/theme-${name}.zsh"
  echo "Switched to: $name ✓ (open new tab for full effect)"
}

# --- Clipboard image → file path (for pasting images into Claude Code) ---
cpimg() {
  local f="/tmp/clipboard-$(date +%s).png"
  pngpaste "$f" 2>/dev/null && echo "$f" | pbcopy && echo "Copied path: $f" || echo "No image in clipboard"
}

# --- Godot project scaffolder: `godot-new my-game` ---
godot-new() {
  local name="${1:-}"
  if [[ -z "$name" ]]; then
    echo "Usage: godot-new <project-name>"
    return 1
  fi

  local dir="$HOME/Desktop/code/$name"
  if [[ -d "$dir" ]]; then
    echo "Already exists: $dir"
    return 1
  fi

  mkdir -p "$dir"

  # project.godot
  cat > "$dir/project.godot" <<'GODOT'
; Engine configuration file.
; It's best edited using the editor UI and not directly,
; this file is not meant to be read by humans.

[application]
config/name=""
config/features=PackedStringArray("4.4", "Forward Plus")

[display]
window/size/viewport_width=1920
window/size/viewport_height=1080
GODOT
  sed -i '' "s|config/name=\"\"|config/name=\"$name\"|" "$dir/project.godot"

  # CLAUDE.md
  cat > "$dir/CLAUDE.md" <<'CLAUDE'
# CLAUDE.md

## Project
- **Engine**: Godot 4.x (GDScript)
- **Renderer**: Forward+

## Rules
- One change at a time for visual work. Verify it runs, then stop.
- Do exactly what's asked — no unrequested improvements.
- GDScript style: snake_case for variables/functions, PascalCase for classes/nodes.
- Use `@onready` over `get_node()` in `_ready()`.
- Use signals over direct references between scenes.
- Prefer composition (child nodes) over deep inheritance.
- Scene files (.tscn) are text — edit carefully, prefer the editor for complex scenes.

## Structure
```
scenes/       # .tscn scene files
scripts/      # .gd script files
assets/       # art, audio, fonts
  sprites/
  audio/
  fonts/
shaders/      # .gdshader files
autoload/     # singleton scripts
```

## Commands
- Run project: `godot --path . --debug` or F5 in editor
- Run specific scene: `godot --path . res://scenes/main.tscn`
- Export: `godot --headless --export-release "macOS"`

## Gotchas
- Node paths break when you rename nodes — use `%UniqueNode` syntax or groups.
- `_process()` runs every frame, `_physics_process()` runs at fixed rate (60fps default).
- Typed arrays: `var enemies: Array[Enemy] = []` — use them for clarity.
- Resource preloading: `const SCENE = preload("res://scenes/thing.tscn")` at top of file.
CLAUDE

  # .gitignore
  cat > "$dir/.gitignore" <<'GIT'
# Godot
.godot/
*.import
export_presets.cfg
*.translation

# OS
.DS_Store
Thumbs.db

# Editor
*.swp
*.swo
GIT

  # Create directory structure
  mkdir -p "$dir/scenes" "$dir/scripts" "$dir/assets/sprites" "$dir/assets/audio" "$dir/assets/fonts" "$dir/shaders" "$dir/autoload"

  # Git init
  git -C "$dir" init -q
  git -C "$dir" add -A
  git -C "$dir" commit -q -m "Initial Godot project scaffold"

  echo "Created: $dir"
  echo "  ├── project.godot"
  echo "  ├── CLAUDE.md"
  echo "  ├── .gitignore"
  echo "  └── scenes/ scripts/ assets/ shaders/ autoload/"
  echo ""
  echo "Open in Godot: open -a Godot $dir/project.godot"
}

# --- Fastfetch on new tab ---
fastfetch

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

