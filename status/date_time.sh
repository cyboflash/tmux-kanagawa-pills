show_date_time() {
  local color=$(get_tmux_option "@kanagawa_date_time_color" "$THM_GRAY")
  local icon=$(get_tmux_option "@kanagawa_date_time_icon" "󰃰")
  local format=$(get_tmux_option "@kanagawa_date_time_text" "%Y-%m-%d %H:%M")
  
  build_module "$format" "$icon" "$color"
}
