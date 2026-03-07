#!/usr/bin/env bash

# This file centralizes all @kanagawa_ option handling.
# It resolves the final values by checking tmux options and providing defaults.

# Determine Plugin Root
if [ -z "$PLUGIN_DIR" ]; then
  PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
fi

# Ensure get_tmux_option is available
source "$PLUGIN_DIR/utils/get_tmux_option.sh"

# --- GLOBAL OPTIONS ---
# Plugins list
KANAGAWA_PLUGINS=$(get_tmux_option "@kanagawa_plugins" "ssh_info session date_time directory")

# Bar background - prioritizing @kanagawa_bar_bg then @kanagawa_bg_bar
KANAGAWA_BAR_BG=$(get_tmux_option "@kanagawa_bar_bg" "$(get_tmux_option "@kanagawa_bg_bar" "default")")

# Alignment and Gap
KANAGAWA_WINDOW_ALIGN=$(get_tmux_option "@kanagawa_window_align" "left")
KANAGAWA_BOTTOM_GAP=$(get_tmux_option "@kanagawa_bottom_gap" "0")

# Separators
KANAGAWA_LEFT_SEP=$(get_tmux_option "@kanagawa_left_sep" "")
KANAGAWA_RIGHT_SEP=$(get_tmux_option "@kanagawa_right_sep" "")
KANAGAWA_WINDOW_SEP=$(get_tmux_option "@kanagawa_window_sep" "")
KANAGAWA_CONNECT_SEP=$(get_tmux_option "@kanagawa_status_connect_separator" "no")

# --- MODULE SPECIFIC ---

# Application
KANAGAWA_APP_ICON=$(get_tmux_option "@kanagawa_app_icon" "")
KANAGAWA_APP_TEXT=$(get_tmux_option "@kanagawa_app_text" "#{pane_current_command}")

# Battery
KANAGAWA_BATTERY_ICON=$(get_tmux_option "@kanagawa_battery_icon" "")

# Date Time
KANAGAWA_DATE_TIME_ICON=$(get_tmux_option "@kanagawa_date_time_icon" "󰃰")
KANAGAWA_DATE_TIME_TEXT=$(get_tmux_option "@kanagawa_date_time_text" "%Y-%m-%d %H:%M")

# Directory
KANAGAWA_DIRECTORY_ICON=$(get_tmux_option "@kanagawa_directory_icon" "")
KANAGAWA_DIRECTORY_TEXT=$(get_tmux_option "@kanagawa_directory_text" "#{?pane_path,#{b:pane_path},#{b:pane_current_path}}")

# Session
KANAGAWA_SESSION_ICON=$(get_tmux_option "@kanagawa_session_icon" "❐")
KANAGAWA_SESSION_TEXT=$(get_tmux_option "@kanagawa_session_text" "#S")

# SSH
KANAGAWA_SSH_ICON=$(get_tmux_option "@kanagawa_ssh_icon" "")
KANAGAWA_SSH_ABBR=$(get_tmux_option "@kanagawa_ssh_abbr" "0")
KANAGAWA_SSH_SHOW_DIR=$(get_tmux_option "@kanagawa_ssh_show_dir" "1")

# Weather
KANAGAWA_WEATHER_ICON=$(get_tmux_option "@kanagawa_weather_icon" "")

# --- WINDOW STYLING ---
KANAGAWA_ACTIVE_BG=$(get_tmux_option "@kanagawa_active_bg" "$THM_BLUE")
KANAGAWA_ACTIVE_FG=$(get_tmux_option "@kanagawa_active_fg" "$THM_BG_BASE")
KANAGAWA_INACTIVE_BG=$(get_tmux_option "@kanagawa_inactive_bg" "$THM_BG_SURFACE")
KANAGAWA_INACTIVE_FG=$(get_tmux_option "@kanagawa_inactive_fg" "$THM_FG_TEXT")

# --- PALETTE OVERRIDES ---
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
