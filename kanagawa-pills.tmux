#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source Utils
source "$CURRENT_DIR/utils/get_tmux_option.sh"
source "$CURRENT_DIR/utils/module_utils.sh"

main() {
  # 1. Load Theme Variables (as Bash variables, not Tmux options)
  local theme=$(get_tmux_option "@kanagawa_theme" "wave")
  source "$CURRENT_DIR/themes/$theme.sh"

  # 2. Global Settings
  # We pass the theme variable (e.g., $THM_BG_BAR) as the default.
  # If the user set @kanagawa_bar_bg in tmux.conf, that takes precedence.
  local bg_bar=$(get_tmux_option "@kanagawa_bar_bg" "$THM_BG_BAR")

  # 3. Build Right Status Modules
  local modules_list=$(get_tmux_option "@kanagawa_plugins" "directory session date_time")
  local status_right_string=""

  for module in $modules_list; do
    if [ -f "$CURRENT_DIR/status/$module.sh" ]; then
      source "$CURRENT_DIR/status/$module.sh"
      # Call the function dynamically (e.g., show_directory)
      local content=$(show_$module)
      status_right_string="$status_right_string$content"
    fi
  done

  # 4. Apply Status Configuration
  tmux set-option -g status-position top
  local align=$(get_tmux_option "@kanagawa_window_align" "left"); tmux set-option -g status-justify "$align"
  tmux set-option -g status-style "bg=$bg_bar"
  tmux set-option -g status-left-length 100
  tmux set-option -g status-right-length 200

  # Fetch Colors (User Override > Theme Default)
  local active_bg=$(get_tmux_option "@kanagawa_active_bg" "$THM_BLUE")
  local active_fg=$(get_tmux_option "@kanagawa_active_fg" "$THM_BG_BASE")
  local inactive_bg=$(get_tmux_option "@kanagawa_inactive_bg" "$THM_BG_SURFACE")
  local inactive_fg=$(get_tmux_option "@kanagawa_inactive_fg" "$THM_FG_TEXT")

  # Separators
  local left_sep=$(get_tmux_option "@kanagawa_left_sep" "")
  local right_sep=$(get_tmux_option "@kanagawa_right_sep" "")
  local window_sep=$(get_tmux_option "@kanagawa_window_sep" "")

  # Set Status Left (Session)
  local session_color=$(get_tmux_option "@kanagawa_session_color" "$THM_YELLOW")
  local session_fg=$(get_tmux_option "@kanagawa_bg_base" "$THM_BG_BASE")

  tmux set-option -g status-left "#[fg=$session_color,bg=$bg_bar]$left_sep#[fg=$session_fg,bg=$session_color,bold] ❐ #S #[fg=$session_color,bg=$bg_bar]$right_sep "

  # Set Status Right (Modules)
  tmux set-option -g status-right "$status_right_string"

  # Set Window Formats
  # Inactive
  tmux set-option -g window-status-format "#[fg=$inactive_bg,bg=$bg_bar]$left_sep#[fg=$inactive_fg,bg=$inactive_bg] #I$window_sep #W #[fg=$inactive_bg,bg=$bg_bar]$right_sep"
  # Active
  tmux set-option -g window-status-current-format "#[fg=$active_bg,bg=$bg_bar]$left_sep#[fg=$active_fg,bg=$active_bg,bold] #I$window_sep #W #[fg=$active_bg,bg=$bg_bar]$right_sep"

  # Styling Borders & Messages
  tmux set-option -g message-style "bg=$active_bg,fg=$active_fg"
  tmux set-option -g pane-border-style "fg=$inactive_bg"
  tmux set-option -g pane-active-border-style "fg=$active_bg"
}

main
