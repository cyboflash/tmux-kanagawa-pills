show_weather() {
  local colors=$(get_module_colors "weather" "$THM_CYAN")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon="$KANAGAWA_WEATHER_ICON"
  local text="#(curl -s wttr.in?format='%%t' || echo 'N/A')"

  build_module "$text" "$icon" "$bg" "$fg"
}
