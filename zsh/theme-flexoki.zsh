# Flexoki color palette
export THEME_BG="#100F0F"
export THEME_FG="#CECDC3"
export THEME_FG_MUTED="#575653"
export THEME_FG_BRIGHT="#FFFCF0"
export THEME_ACCENT="#4385BE"
export THEME_RED="#AF3029"
export THEME_ORANGE="#BC5215"
export THEME_GREEN="#66800B"
export THEME_PURPLE="#A02F6F"
export THEME_SURFACE="#282726"
export THEME_OVERLAY="#2B2A28"

# fzf
export FZF_DEFAULT_OPTS="
  --color=bg+:${THEME_SURFACE},bg:${THEME_BG},fg:${THEME_FG},fg+:${THEME_FG_BRIGHT}
  --color=hl:${THEME_ACCENT},hl+:${THEME_ACCENT},info:${THEME_FG_MUTED},marker:${THEME_GREEN}
  --color=prompt:${THEME_RED},spinner:${THEME_PURPLE},pointer:${THEME_PURPLE},header:${THEME_ACCENT}
  --color=border:${THEME_SURFACE},separator:${THEME_SURFACE}
  --border=rounded --padding=1 --prompt='❯ ' --pointer='▌'
"
