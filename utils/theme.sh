#!/usr/bin/env bash

# Centralized theme loader for kanagawa-pills
# Load order: palette → palette overrides → theme (role mappings) → custom overrides

# Determine Plugin Root
if [ -z "$PLUGIN_DIR" ]; then
  PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
fi

source "$PLUGIN_DIR/utils/get_tmux_option.sh"

# 1. Load Palette (color definitions)
THM_PALETTE=$(get_tmux_option "@kanagawa_palette" "wave")
if [ -f "$PLUGIN_DIR/palettes/$THM_PALETTE.sh" ]; then
  source "$PLUGIN_DIR/palettes/$THM_PALETTE.sh"
fi

# 2. Apply individual palette overrides (before role mapping)
THM_BG_BASE=$(get_tmux_option "@kanagawa_bg_base" "$THM_BG_BASE")
THM_BG_SURFACE=$(get_tmux_option "@kanagawa_bg_surface" "$THM_BG_SURFACE")
THM_FG_TEXT=$(get_tmux_option "@kanagawa_fg_text" "$THM_FG_TEXT")
THM_BG_BAR=$(get_tmux_option "@kanagawa_bg_bar" "$THM_BG_BAR")
THM_RED=$(get_tmux_option "@kanagawa_red" "$THM_RED")
THM_GREEN=$(get_tmux_option "@kanagawa_green" "$THM_GREEN")
THM_YELLOW=$(get_tmux_option "@kanagawa_yellow" "$THM_YELLOW")
THM_BLUE=$(get_tmux_option "@kanagawa_blue" "$THM_BLUE")
THM_MAGENTA=$(get_tmux_option "@kanagawa_magenta" "$THM_MAGENTA")
THM_CYAN=$(get_tmux_option "@kanagawa_cyan" "$THM_CYAN")
THM_ORANGE=$(get_tmux_option "@kanagawa_orange" "$THM_ORANGE")
THM_GRAY=$(get_tmux_option "@kanagawa_gray" "$THM_GRAY")

# 3. Load Theme (role mappings — now sees overridden palette values)
THM_THEME=$(get_tmux_option "@kanagawa_theme" "default")
if [ -f "$PLUGIN_DIR/themes/$THM_THEME.sh" ]; then
  source "$PLUGIN_DIR/themes/$THM_THEME.sh"
fi

# 4. Load Custom Override File (highest priority)
THM_CUSTOM_FILE=$(get_tmux_option "@kanagawa_custom_theme_file" "")
if [ -f "$THM_CUSTOM_FILE" ]; then
  source "$THM_CUSTOM_FILE"
fi
