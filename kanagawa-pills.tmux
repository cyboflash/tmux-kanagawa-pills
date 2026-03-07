#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source Utils
source "$CURRENT_DIR/utils/get_tmux_option.sh"
source "$CURRENT_DIR/utils/module_utils.sh"

main() {
  tmux set-option -g mouse on
  
  # 1. Load configuration and theme
  source "$CURRENT_DIR/utils/options.sh"
  source "$CURRENT_DIR/utils/theme.sh"

  # 2. Global Settings
  local bg_bar="$KANAGAWA_BAR_BG"

  # 3. Build Right Status Modules
  local modules_list="$KANAGAWA_PLUGINS"
  local status_right_string=""

  for module in $modules_list; do
    if [ -f "$CURRENT_DIR/status/$module.sh" ]; then
      source "$CURRENT_DIR/status/$module.sh"
      local content=$(show_$module)
      status_right_string="$status_right_string$content"
    fi
  done

  # 4. Apply Status Configuration
  tmux set-option -g status-position top

  # --- ALIGNMENT LOGIC ---
  local align="$KANAGAWA_WINDOW_ALIGN"
  if [[ "$align" == "center" ]]; then
      align="centre"
  fi
  tmux set-option -g status-justify "$align"

  tmux set-option -g status-style "bg=$bg_bar"
  tmux set-option -g status-left-length 100
  tmux bind-key -n MouseDown1StatusLeft choose-tree -Zs  tmux set-option -g status-right-length 200

  # Fetch Colors (Already resolved in options.sh)
  local active_bg="$KANAGAWA_ACTIVE_BG"
  local active_fg="$KANAGAWA_ACTIVE_FG"
  local inactive_bg="$KANAGAWA_INACTIVE_BG"
  local inactive_fg="$KANAGAWA_INACTIVE_FG"

  # Separators
  local left_sep="$KANAGAWA_LEFT_SEP"
  local right_sep="$KANAGAWA_RIGHT_SEP"
  local window_sep="$KANAGAWA_WINDOW_SEP"

  # Set Status Left (Session)
  local session_colors=$(get_module_colors "session" "$THM_YELLOW" "$THM_BG_BASE")
  local session_color=$(echo "$session_colors" | cut -d' ' -f1)
  local session_fg=$(echo "$session_colors" | cut -d' ' -f2)

  tmux set-option -g status-left "#[fg=$session_color,bg=$bg_bar]$left_sep#[fg=$session_fg,bg=$session_color,bold] ❐ #S #[fg=$session_color,bg=$bg_bar]$right_sep "
  tmux bind-key -n MouseDown1StatusLeft choose-tree -Zs
  # Set Status Right (Modules)
  tmux set-option -g status-right "$status_right_string"

  # Set Window Formats
  tmux set-option -g window-status-format "#[fg=$inactive_bg,bg=$bg_bar]$left_sep#[fg=$inactive_fg,bg=$inactive_bg] #I$window_sep #W #[fg=$inactive_bg,bg=$bg_bar]$right_sep"
  tmux set-option -g window-status-current-format "#[fg=$active_bg,bg=$bg_bar]$left_sep#[fg=$active_fg,bg=$active_bg,bold] #I$window_sep #W #[fg=$active_bg,bg=$bg_bar]$right_sep"

  # Styling Borders & Messages
  tmux set-option -g message-style "bg=$active_bg,fg=$active_fg"
  tmux set-option -g pane-border-style "fg=$inactive_bg"
  tmux set-option -g pane-active-border-style "fg=$active_bg"

  # --- GAP LOGIC ---
  # Adds blank lines below the status bar to create a "gap"
  local gap="$KANAGAWA_BOTTOM_GAP"
  if [ "$gap" -gt "0" ]; then
    # Total status lines = 1 (main) + gap
    local total_lines=$((gap + 1))
    tmux set-option -g status "$total_lines"

    # Set the extra lines to be empty and transparent
    for ((i=1; i<total_lines; i++)); do
      tmux set-option -g status-format["$i"] "#[bg=default]"
    done
  else
    # Reset to default if gap is 0
    tmux set-option -g status 1
  fi
}

main
