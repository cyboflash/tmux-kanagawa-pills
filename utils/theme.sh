#!/usr/bin/env bash

# Centralized theme loader for kanagawa-pills
# This script resolves the active theme, applies custom file overrides,
# and finally applies individual tmux option overrides.

# Determine Plugin Root
if [ -z "$PLUGIN_DIR" ]; then
  PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
fi

# Ensure get_tmux_option is available
source "$PLUGIN_DIR/utils/get_tmux_option.sh"

# 1. Load Base Theme Variables
THM_THEME=$(get_tmux_option "@kanagawa_theme" "wave")
if [ -f "$PLUGIN_DIR/themes/$THM_THEME.sh" ]; then
  source "$PLUGIN_DIR/themes/$THM_THEME.sh"
fi

# 2. Load Custom Theme File (High priority override)
THM_CUSTOM_FILE=$(get_tmux_option "@kanagawa_custom_theme_file" "")
if [ -f "$THM_CUSTOM_FILE" ]; then
  source "$THM_CUSTOM_FILE"
fi

