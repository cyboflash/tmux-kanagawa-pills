show_directory() {
  # Check if in SSH session
  local script_path="$CURRENT_DIR/utils/get_ssh_status.sh"
  
  local colors=$(get_module_colors "directory" "$THM_BLUE")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon=$(get_tmux_option "@kanagawa_directory_icon" "")
  local text=$(get_tmux_option "@kanagawa_directory_text" "#{?pane_path,#{b:pane_path},#{b:pane_current_path}}")

  local module_output=$(build_module "$text" "$icon" "$bg" "$fg")
  # Escape all commas to prevent them from being interpreted as separators in the outer tmux conditional
  local escaped_output="${module_output//,/\\,}"

  # Use the simplified call (only PID needed for toggle check)
  # When inside an SSH session, this script outputs the SSH pill (non-empty), 
  # so tmux conditional will correctly hide the standalone directory pill.
  echo "#{?#($script_path #{pane_pid}),,$escaped_output}"
}
