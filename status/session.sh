show_session() {
  local colors=$(get_module_colors "session" "$THM_YELLOW")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon=$(get_tmux_option "@kanagawa_session_icon" "❐")
  local text=$(get_tmux_option "@kanagawa_session_text" "#S")

  build_module "$text" "$icon" "$bg" "$fg"
}
