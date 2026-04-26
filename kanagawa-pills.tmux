#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/utils/get_tmux_option.sh"

main() {
  # 1. Load theme (palette + roles), then global options, then module utils
  source "$CURRENT_DIR/utils/theme.sh"
  source "$CURRENT_DIR/utils/options.sh"
  source "$CURRENT_DIR/utils/module_utils.sh"

  # 2. Cache resolved values for runtime scripts
  local _var
  for _var in $(compgen -v | grep -E '^(THM_|KANAGAWA_)'); do
    tmux set-environment -g "$_var" "${!_var}"
  done
  tmux set-environment -g KANAGAWA_CACHE 1

  # 3. Build left status modules
  local status_left=""
  for module in $KANAGAWA_LEFT_PLUGINS; do
    if [ -f "$CURRENT_DIR/status/$module.sh" ]; then
      source "$CURRENT_DIR/status/$module.sh"
      status_left="$status_left$(show_$module)"
    fi
  done

  # 4. Build right status modules
  local status_right=""
  for module in $KANAGAWA_RIGHT_PLUGINS; do
    if [ -f "$CURRENT_DIR/status/$module.sh" ]; then
      source "$CURRENT_DIR/status/$module.sh"
      status_right="$status_right$(show_$module)"
    fi
  done

  # 5. Apply tmux settings
  local bg_bar="$KANAGAWA_BAR_BG"
  local align="$KANAGAWA_WINDOW_ALIGN"
  if [[ "$align" == "center" ]]; then
    align="centre"
  fi

  tmux set-option -g status-position "$KANAGAWA_STATUS_POSITION"
  tmux set-option -g status-justify "$align"
  tmux set-option -g status-style "bg=$bg_bar"
  tmux set-option -g status-left-length 100
  tmux set-option -g status-right-length 200
  tmux set-option -g status-left "$status_left"
  tmux set-option -g status-right "$status_right"

  tmux bind-key -n MouseDown1StatusLeft choose-tree -Zs

  # 6. Window formats
  local left_sep="$KANAGAWA_LEFT_SEP"
  local right_sep="$KANAGAWA_RIGHT_SEP"
  local window_sep="$KANAGAWA_WINDOW_SEP"
  local active_bg="$KANAGAWA_ACTIVE_BG"
  local active_fg="$KANAGAWA_ACTIVE_FG"
  local inactive_bg="$KANAGAWA_INACTIVE_BG"
  local inactive_fg="$KANAGAWA_INACTIVE_FG"

  tmux set-option -g window-status-format "#[fg=$inactive_bg,bg=$bg_bar]$left_sep#[fg=$inactive_fg,bg=$inactive_bg] #I$window_sep #W #[fg=$inactive_bg,bg=$bg_bar]$right_sep"
  tmux set-option -g window-status-current-format "#[fg=$active_bg,bg=$bg_bar]$left_sep#[fg=$active_fg,bg=$active_bg,bold] #I$window_sep #W #[fg=$active_bg,bg=$bg_bar]$right_sep"

  # 7. Borders & messages
  tmux set-option -g message-style "bg=$active_bg,fg=$active_fg"
  tmux set-option -g pane-border-style "fg=$inactive_bg"
  tmux set-option -g pane-active-border-style "fg=$active_bg"

  # 8. Gap (extra empty status lines)
  local gap="$KANAGAWA_BOTTOM_GAP"
  if [ "$gap" -gt "0" ]; then
    local total_lines=$((gap + 1))
    tmux set-option -g status "$total_lines"
    for ((i=1; i<total_lines; i++)); do
      tmux set-option -g status-format["$i"] "#[bg=default]"
    done
  else
    tmux set-option -g status on
  fi
}

main
