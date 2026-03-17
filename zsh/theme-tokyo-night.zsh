# Tokyo Night color palette
export THEME_BG="#1a1b26"
export THEME_FG="#a9b1d6"
export THEME_FG_MUTED="#444b6a"
export THEME_FG_BRIGHT="#c0caf5"
export THEME_ACCENT="#7aa2f7"
export THEME_RED="#f7768e"
export THEME_ORANGE="#ff9e64"
export THEME_GREEN="#9ece6a"
export THEME_PURPLE="#bb9af7"
export THEME_SURFACE="#32344a"
export THEME_OVERLAY="#292e42"

# fzf
export FZF_DEFAULT_OPTS="
  --color=bg+:${THEME_SURFACE},bg:${THEME_BG},fg:${THEME_FG},fg+:${THEME_FG_BRIGHT}
  --color=hl:${THEME_ACCENT},hl+:${THEME_ACCENT},info:${THEME_FG_MUTED},marker:${THEME_GREEN}
  --color=prompt:${THEME_RED},spinner:${THEME_PURPLE},pointer:${THEME_PURPLE},header:${THEME_ACCENT}
  --color=border:${THEME_SURFACE},separator:${THEME_SURFACE}
  --border=rounded --padding=1 --prompt='❯ ' --pointer='▌'
"
