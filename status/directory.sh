show_directory() {
  local script_path="$CURRENT_DIR/utils/get_directory_status.sh"
  local text=$(get_tmux_option "@kanagawa_directory_text" "#{?pane_path,#{b:pane_path},#{b:pane_current_path}}")

  # Pass only PID and the resolved directory name (via tmux variable)
  echo "#($script_path #{pane_pid} '$text')"
}
