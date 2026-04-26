show_weather() {
  local icon=$(get_tmux_option "@kanagawa_weather_icon" "")
  local text="#(curl -s wttr.in?format='%%t' || echo 'N/A')"
  local colors=$(get_module_colors "weather" "$THM_ROLE_WEATHER")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)

  build_module "$text" "$icon" "$bg" "$fg"
}
