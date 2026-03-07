#!/usr/bin/env bash

# Determine Plugin Root and load theme
PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
source "$PLUGIN_DIR/utils/theme.sh"
source "$PLUGIN_DIR/utils/module_utils.sh"

PID=$1
DIR=$2

# Function to check a specific PID for SSH
check_pid_for_ssh() {
    local check_pid=$1
    
    if [ "$(uname)" == "Darwin" ]; then
        local cmd=$(ps -o command= -p "$check_pid" 2>/dev/null)
    else
        local cmd=$(ps -o args= -p "$check_pid" 2>/dev/null)
    fi

    # Check if command contains 'ssh' (start or middle)
    if [[ "$cmd" =~ (^|/)ssh([[:space:]]|$) ]]; then
        echo "$cmd"
        return 0
    fi
    return 1
}

# 1. Check for SSH
SSH_CMD=$(check_pid_for_ssh "$PID")

if [ -z "$SSH_CMD" ]; then
    CHILD_PIDS=$(pgrep -P "$PID")
    for child in $CHILD_PIDS; do
        SSH_CMD=$(check_pid_for_ssh "$child")
        if [ -n "$SSH_CMD" ]; then
            break
        fi
    done
fi

# 2. If SSH was NOT found, output the directory pill
if [ -z "$SSH_CMD" ]; then
  # Fetch directory colors and settings
  COLORS=$(get_module_colors "directory" "$THM_BLUE")
  BG=$(echo "$COLORS" | cut -d' ' -f1)
  FG=$(echo "$COLORS" | cut -d' ' -f2)
  ICON=$(get_tmux_option "@kanagawa_directory_icon" "")
  
  # When calling build_module, we don't want the text to be re-evaluated by tmux conditional 
  # so we use literal values. We also need to be careful with the text passed from show_directory.
  # The text is likely "#{b:pane_path}" or similar.
  build_module "$DIR" "$ICON" "$BG" "$FG"
else
  # Output NOTHING
  echo ""
fi
