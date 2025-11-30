#!/usr/bin/env bash

# This function builds the "Pill" string for a specific module
# Usage: build_module "text" "icon" "color"
build_module() {
  local module_text="$1"
  local module_icon="$2"
  local module_color="$3"

  local left_sep=$(get_tmux_option "@kanagawa_left_sep" "")
  local right_sep=$(get_tmux_option "@kanagawa_right_sep" "")
  local bg_bar=$(get_tmux_option "@kanagawa_bar_bg" "default")
  
  # Fetch surface color (User Override > Theme Default)
  # We rely on the theme being sourced in main to provide $THM_BG_SURFACE default
  local bg_surface=$(get_tmux_option "@kanagawa_bg_surface" "$THM_BG_SURFACE")

  echo "#[fg=$module_color,bg=$bg_bar]$left_sep#[fg=$bg_surface,bg=$module_color,bold]$module_icon $module_text#[fg=$module_color,bg=$bg_bar]$right_sep "
}
