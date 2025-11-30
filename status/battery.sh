show_battery() {
  local color=$(get_tmux_option "@kanagawa_battery_color" "$THM_ORANGE")
  local icon=$(get_tmux_option "@kanagawa_battery_icon" "")
  # Simple cross-platform battery check
  local text="#{?battery_percentage,#{battery_percentage},#(pmset -g batt | grep -o '[0-9]*%%' || echo 'N/A')}"

  build_module "$text" "$icon" "$color"
}
