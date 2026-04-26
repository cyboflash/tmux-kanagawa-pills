show_battery() {
  local icon=$(get_tmux_option "@kanagawa_battery_icon" "")
  local text="#{?battery_percentage,#{battery_percentage},#(pmset -g batt | grep -o '[0-9]*%%' || echo 'N/A')}"
  local colors=$(get_module_colors "battery" "$THM_ROLE_BATTERY")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)

  build_module "$text" "$icon" "$bg" "$fg"
}
