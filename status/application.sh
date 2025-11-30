show_application() {
  local color=$(get_tmux_option "@kanagawa_app_color" "$THM_GREEN")
  local icon=$(get_tmux_option "@kanagawa_app_icon" "")
  local text=$(get_tmux_option "@kanagawa_app_text" "#{pane_current_command}")

  build_module "$text" "$icon" "$color"
}
