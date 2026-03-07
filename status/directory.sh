show_directory() {
  local script_path="$CURRENT_DIR/utils/get_directory_status.sh"
  local text="$KANAGAWA_DIRECTORY_TEXT"

  # Pass only PID and the resolved directory name (via tmux variable)
  echo "#($script_path #{pane_pid} '$text')"
}
