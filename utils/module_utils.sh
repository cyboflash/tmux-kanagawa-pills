#!/usr/bin/env bash

# Build a "Pill" format string for a module
# Usage: build_module "text" "icon" "bg_color" "fg_color"
build_module() {
  # Load config: prefer cached tmux environment, fall back to full source
  if [ -z "$THM_BG_SURFACE" ]; then
    local _cached
    _cached=$(tmux show-environment -g KANAGAWA_CACHE 2>/dev/null)
    if [[ "$_cached" == KANAGAWA_CACHE=1 ]]; then
      eval "$(tmux show-environment -g | grep -E '^(THM_|KANAGAWA_)' )"
    else
      local plugin_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
      source "$plugin_dir/utils/theme.sh"
      source "$plugin_dir/utils/options.sh"
    fi
  fi

  local module_text="$1"
  local module_icon="$2"
  local module_bg="$3"
  local module_fg="${4:-$THM_ROLE_MODULE_FG}"

  local left_sep="$KANAGAWA_LEFT_SEP"
  local right_sep="$KANAGAWA_RIGHT_SEP"
  local bg_bar="$KANAGAWA_BAR_BG"

  local spacer=" "
  if [ "$KANAGAWA_CONNECT_SEP" == "yes" ]; then
    spacer=""
  fi

  echo "#[fg=$module_bg,bg=$bg_bar]$left_sep#[fg=$module_fg,bg=$module_bg,bold]$module_icon $module_text#[fg=$module_bg,bg=$bg_bar]$right_sep$spacer"
}

# Resolve bg/fg colors for a module, respecting user overrides
# Usage: get_module_colors "prefix" "default_bg" ["default_fg"]
get_module_colors() {
  local prefix="$1"
  local default_bg="$2"
  local default_fg="${3:-$THM_ROLE_MODULE_FG}"

  local bg=$(get_tmux_option "@kanagawa_${prefix}_bg" "$(get_tmux_option "@kanagawa_${prefix}_color" "$default_bg")")
  local fg=$(get_tmux_option "@kanagawa_${prefix}_fg" "$default_fg")

  echo "$bg $fg"
}
