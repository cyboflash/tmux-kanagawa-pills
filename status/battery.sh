show_battery() {
  local colors=$(get_module_colors "battery" "$THM_ORANGE")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon="$KANAGAWA_BATTERY_ICON"
  # Simple cross-platform battery check
  local text="#{?battery_percentage,#{battery_percentage},#(pmset -g batt | grep -o '[0-9]*%%' || echo 'N/A')}"

  build_module "$text" "$icon" "$bg" "$fg"
}
