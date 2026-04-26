show_session() {
  local icon=$(get_tmux_option "@kanagawa_session_icon" "❐")
  local text=$(get_tmux_option "@kanagawa_session_text" "#S")
  local colors=$(get_module_colors "session" "$THM_ROLE_SESSION")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)

  build_module "$text" "$icon" "$bg" "$fg"
}
