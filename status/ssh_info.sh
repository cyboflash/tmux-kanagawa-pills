show_ssh_info() {
  local script_path="$CURRENT_DIR/status/runtime/pane_status.sh"

  echo "#($script_path ssh #{pane_pid} '#{?pane_path,#{pane_path},#{pane_current_path}}')"
}
