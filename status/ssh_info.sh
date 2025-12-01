show_ssh_info() {
  # 1. Fetch all visual configuration
  local color=$(get_tmux_option "@kanagawa_ssh_color" "$THM_MAGENTA")
  local text_color=$(get_tmux_option "@kanagawa_bg_surface" "$THM_BG_SURFACE")
  local bar_bg=$(get_tmux_option "@kanagawa_bar_bg" "default")
  local l_sep=$(get_tmux_option "@kanagawa_left_sep" "")
  local r_sep=$(get_tmux_option "@kanagawa_right_sep" "")
  local icon=$(get_tmux_option "@kanagawa_ssh_icon" "")
  local abbr=$(get_tmux_option "@kanagawa_ssh_abbr" "0")

  local script_path="$CURRENT_DIR/utils/get_ssh_status.sh"

  # 2. Pass everything to the script
  # Order: PID, ABBR, COLOR, TEXT_COLOR, BAR_BG, L_SEP, R_SEP, ICON
  echo "#($script_path #{pane_pid} '$abbr' '$color' '$text_color' '$bar_bg' '$l_sep' '$r_sep' '$icon')"
}
