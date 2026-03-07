show_ssh_info() {
  local script_path="$CURRENT_DIR/utils/get_ssh_status.sh"

  # Pass only PID and DIR; the script fetches other options directly
  echo "#($script_path #{pane_pid} '#{?pane_path,#{pane_path},#{pane_current_path}}')"
}
