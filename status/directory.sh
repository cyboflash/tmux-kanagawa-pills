show_directory() {
  # Check if in SSH session
  local script_path="$CURRENT_DIR/utils/get_ssh_status.sh"
  local is_ssh=$(#($script_path #{pane_pid} '0' 'default' '' '' '' '' '0'))
  
  # If is_ssh is not empty, it means we are in SSH, so don't show the directory pill
  # However, tmux interpolation in shell scripts is tricky.
  # We should use a tmux-native way to conditionally show it if possible, 
  # or just let the script handle the logic.

  local colors=$(get_module_colors "directory" "$THM_BLUE")
  local bg=$(echo "$colors" | cut -d' ' -f1)
  local fg=$(echo "$colors" | cut -d' ' -f2)
  local icon=$(get_tmux_option "@kanagawa_directory_icon" "")
  local text=$(get_tmux_option "@kanagawa_directory_text" "#{?pane_path,#{b:pane_path},#{b:pane_current_path}}")

  # We use tmux conditional to hide it if ssh_info is active and showing something
  # But directory doesn't know about ssh_info easily without re-running the check.
  
  # Let's use the same script to check
  echo "#{?#( $script_path #{pane_pid} 0 default '' '' '' '' 0 ),,$(build_module "$text" "$icon" "$bg" "$fg")}"
}
