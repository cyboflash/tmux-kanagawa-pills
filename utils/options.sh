#!/usr/bin/env bash

# Global options only — module-specific options live in their respective status/*.sh files.

if [ -z "$PLUGIN_DIR" ]; then
  PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
fi

source "$PLUGIN_DIR/utils/get_tmux_option.sh"

# --- LAYOUT ---
KANAGAWA_LEFT_PLUGINS=$(get_tmux_option "@kanagawa_left_plugins" "session")
KANAGAWA_RIGHT_PLUGINS=$(get_tmux_option "@kanagawa_right_plugins" "ssh_info date_time directory")
KANAGAWA_BAR_BG=$(get_tmux_option "@kanagawa_bar_bg" "default")
KANAGAWA_WINDOW_ALIGN=$(get_tmux_option "@kanagawa_window_align" "left")
KANAGAWA_BOTTOM_GAP=$(get_tmux_option "@kanagawa_bottom_gap" "0")
KANAGAWA_STATUS_POSITION=$(get_tmux_option "@kanagawa_status_position" "top")

# --- SEPARATORS ---
KANAGAWA_LEFT_SEP=$(get_tmux_option "@kanagawa_left_sep" "")
KANAGAWA_RIGHT_SEP=$(get_tmux_option "@kanagawa_right_sep" "")
KANAGAWA_WINDOW_SEP=$(get_tmux_option "@kanagawa_window_sep" "")
KANAGAWA_CONNECT_SEP=$(get_tmux_option "@kanagawa_status_connect_separator" "no")

# --- WINDOW STYLING ---
KANAGAWA_ACTIVE_BG=$(get_tmux_option "@kanagawa_active_bg" "$THM_ROLE_ACTIVE_BG")
KANAGAWA_ACTIVE_FG=$(get_tmux_option "@kanagawa_active_fg" "$THM_ROLE_ACTIVE_FG")
KANAGAWA_INACTIVE_BG=$(get_tmux_option "@kanagawa_inactive_bg" "$THM_ROLE_INACTIVE_BG")
KANAGAWA_INACTIVE_FG=$(get_tmux_option "@kanagawa_inactive_fg" "$THM_ROLE_INACTIVE_FG")
