show_application() {
  local icon=$(get_tmux_option "@kanagawa_app_icon" "")
  local text=$(get_tmux_option "@kanagawa_app_text" "#{pane_current_command}")
  local colors=$(get_module_colors "app" "$THM_ROLE_APP")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)

  build_module "$text" "$icon" "$bg" "$fg"
}
