#!/usr/bin/env bash

# This function builds the "Pill" string for a specific module
# Usage: build_module "text" "icon" "bg_color" "fg_color"
build_module() {
  # Ensure theme and options are loaded if we are called in a context that hasn't loaded it
  if [ -z "$THM_BG_SURFACE" ]; then
    local plugin_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
    source "$plugin_dir/utils/theme.sh"
    source "$plugin_dir/utils/options.sh"
  fi

  local module_text="$1"
  local module_icon="$2"
  local module_bg="$3"
  local module_fg="$4"

  local left_sep="$KANAGAWA_LEFT_SEP"
  local right_sep="$KANAGAWA_RIGHT_SEP"
  local bg_bar="$KANAGAWA_BAR_BG"

  # Fetch default foreground color (User Override > Theme Default)
  if [ -z "$module_fg" ]; then
    module_fg="$THM_BG_SURFACE"
  fi

  local connect="$KANAGAWA_CONNECT_SEP"
  local spacer=" "

  if [ "$connect" == "yes" ]; then
    spacer=""
  fi

  echo "#[fg=$module_bg,bg=$bg_bar]$left_sep#[fg=$module_fg,bg=$module_bg,bold]$module_icon $module_text#[fg=$module_bg,bg=$bg_bar]$right_sep "
}

# Usage: get_module_colors "prefix" "default_bg" ["default_fg"]
get_module_colors() {
  local prefix="$1"
  local default_bg="$2"
  local default_fg="$3"

  if [ -z "$default_fg" ]; then
    default_fg="$THM_BG_SURFACE"
  fi

  # Support legacy _color option for background
  local bg=$(get_tmux_option "@kanagawa_${prefix}_bg" "$(get_tmux_option "@kanagawa_${prefix}_color" "$default_bg")")
  local fg=$(get_tmux_option "@kanagawa_${prefix}_fg" "$default_fg")

  echo "$bg $fg"
}
