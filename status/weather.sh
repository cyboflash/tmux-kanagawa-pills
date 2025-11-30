show_weather() {
  local color=$(get_tmux_option "@kanagawa_weather_color" "$THM_CYAN")
  local icon=$(get_tmux_option "@kanagawa_weather_icon" "")
  local text="#(curl -s wttr.in?format='%%t' || echo 'N/A')"

  build_module "$text" "$icon" "$color"
}
