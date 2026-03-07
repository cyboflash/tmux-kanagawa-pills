show_ssh_info() {
  # 1. Fetch all visual configuration
  local colors=$(get_module_colors "ssh" "$THM_MAGENTA")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local bar_bg=$(get_tmux_option "@kanagawa_bar_bg" "default")
  local l_sep=$(get_tmux_option "@kanagawa_left_sep" "")
  local r_sep=$(get_tmux_option "@kanagawa_right_sep" "")
  local icon=$(get_tmux_option "@kanagawa_ssh_icon" "")
  local abbr=$(get_tmux_option "@kanagawa_ssh_abbr" "0")
  local show_dir=$(get_tmux_option "@kanagawa_ssh_show_dir" "1")

  local script_path="$CURRENT_DIR/utils/get_ssh_status.sh"

  # 2. Pass everything to the script
  # Order: PID, ABBR, BG, FG, BAR_BG, L_SEP, R_SEP, ICON, DIR, SHOW_DIR
  echo "#($script_path #{pane_pid} '$abbr' '$bg' '$fg' '$bar_bg' '$l_sep' '$r_sep' '$icon' '#{pane_current_path}' '$show_dir')"
}
