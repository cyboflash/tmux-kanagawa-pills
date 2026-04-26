show_directory() {
  local script_path="$CURRENT_DIR/status/runtime/pane_status.sh"
  local text=$(get_tmux_option "@kanagawa_directory_text" "#{?pane_path,#{b:pane_path},#{b:pane_current_path}}")

  echo "#($script_path dir #{pane_pid} '$text')"
}
