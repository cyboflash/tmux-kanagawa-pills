show_application() {
  local colors=$(get_module_colors "app" "$THM_GREEN")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon="$KANAGAWA_APP_ICON"
  local text="$KANAGAWA_APP_TEXT"

  build_module "$text" "$icon" "$bg" "$fg"
}
