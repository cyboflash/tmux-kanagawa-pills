show_session() {
  local colors=$(get_module_colors "session" "$THM_YELLOW")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon="$KANAGAWA_SESSION_ICON"
  local text="$KANAGAWA_SESSION_TEXT"

  build_module "$text" "$icon" "$bg" "$fg"
}
