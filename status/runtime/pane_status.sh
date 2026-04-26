#!/usr/bin/env bash

# Unified pane-status runtime script.
# Called by tmux on every refresh via #(pane_status.sh <mode> <pid> <dir>)
# mode: "ssh" → output SSH pill or nothing
#       "dir" → output directory pill or nothing (suppressed during SSH)

PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
source "$PLUGIN_DIR/utils/get_tmux_option.sh"
source "$PLUGIN_DIR/utils/ssh_detect.sh"
source "$PLUGIN_DIR/utils/module_utils.sh"

MODE=$1
PID=$2
DIR=$3

SSH_CMD=$(find_ssh_cmd "$PID")

if [ "$MODE" == "ssh" ]; then
  [ -z "$SSH_CMD" ] && exit 0

  COLORS=$(get_module_colors "ssh" "$THM_ROLE_SSH")
  BG=$(echo "$COLORS" | cut -d' ' -f1)
  FG=$(echo "$COLORS" | cut -d' ' -f2)

  local_icon=$(get_tmux_option "@kanagawa_ssh_icon" "")
  local_abbr=$(get_tmux_option "@kanagawa_ssh_abbr" "0")
  local_show_dir=$(get_tmux_option "@kanagawa_ssh_show_dir" "1")
  local_dir_icon=$(get_tmux_option "@kanagawa_directory_icon" "")

  HOST=$(extract_ssh_host "$SSH_CMD" "$local_abbr")
  output="$local_icon ssh:$HOST"

  if [ "$local_show_dir" == "1" ]; then
    output="$output $local_dir_icon $(basename "$DIR")"
  fi

  build_module "$output" "" "$BG" "$FG"

elif [ "$MODE" == "dir" ]; then
  [ -n "$SSH_CMD" ] && exit 0

  COLORS=$(get_module_colors "directory" "$THM_ROLE_DIRECTORY")
  BG=$(echo "$COLORS" | cut -d' ' -f1)
  FG=$(echo "$COLORS" | cut -d' ' -f2)
  local_icon=$(get_tmux_option "@kanagawa_directory_icon" "")

  build_module "$DIR" "$local_icon" "$BG" "$FG"
fi
