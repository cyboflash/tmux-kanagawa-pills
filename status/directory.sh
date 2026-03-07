show_directory() {
  local colors=$(get_module_colors "directory" "$THM_BLUE")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon=$(get_tmux_option "@kanagawa_directory_icon" "")
  local text=$(get_tmux_option "@kanagawa_directory_text" "#{?pane_path,#{b:pane_path},#{b:pane_current_path}}")

  build_module "$text" "$icon" "$bg" "$fg"
}
