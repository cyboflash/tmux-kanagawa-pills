show_date_time() {
  local icon=$(get_tmux_option "@kanagawa_date_time_icon" "󰃰")
  local format=$(get_tmux_option "@kanagawa_date_time_text" "%Y-%m-%d %H:%M")
  local colors=$(get_module_colors "date_time" "$THM_ROLE_DATETIME")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)

  build_module "$format" "$icon" "$bg" "$fg"
}
