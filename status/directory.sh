show_directory() {
  local color=$(get_tmux_option "@kanagawa_directory_color" "$THM_BLUE")
  local icon=$(get_tmux_option "@kanagawa_directory_icon" "")
  local text=$(get_tmux_option "@kanagawa_directory_text" "#{b:pane_current_path}")

  build_module "$text" "$icon" "$color"
}
