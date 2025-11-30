show_session() {
  local color=$(get_tmux_option "@kanagawa_session_color" "$THM_YELLOW")
  local icon=$(get_tmux_option "@kanagawa_session_icon" "❐")
  local text=$(get_tmux_option "@kanagawa_session_text" "#S")

  build_module "$text" "$icon" "$color"
}
