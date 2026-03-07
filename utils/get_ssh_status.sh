#!/usr/bin/env bash

# Determine Plugin Root and load theme
PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
source "$PLUGIN_DIR/utils/theme.sh"
source "$PLUGIN_DIR/utils/module_utils.sh"

PID=$1
DIR=$2

# Fetch all configuration directly from tmux for robustness
ABBR_LEN=$(get_tmux_option "@kanagawa_ssh_abbr" "0")
BAR_BG=$(get_tmux_option "@kanagawa_bar_bg" "default")
L_SEP=$(get_tmux_option "@kanagawa_left_sep" "")
R_SEP=$(get_tmux_option "@kanagawa_right_sep" "")
ICON=$(get_tmux_option "@kanagawa_ssh_icon" "")
SHOW_DIR=$(get_tmux_option "@kanagawa_ssh_show_dir" "1")
DIR_ICON=$(get_tmux_option "@kanagawa_directory_icon" "")

# Resolve SSH colors
COLORS=$(get_module_colors "ssh" "$THM_MAGENTA")
BG=$(echo "$COLORS" | cut -d' ' -f1)
FG=$(echo "$COLORS" | cut -d' ' -f2)

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

# 1. Check the Pane PID (The Shell)
SSH_CMD=$(check_pid_for_ssh "$PID")

# 2. If not found, check immediate Child Processes (The command running in shell)
if [ -z "$SSH_CMD" ]; then
    # pgrep -P finds children of the shell
    CHILD_PIDS=$(pgrep -P "$PID")
    for child in $CHILD_PIDS; do
        SSH_CMD=$(check_pid_for_ssh "$child")
        if [ -n "$SSH_CMD" ]; then
            break
        fi
    done
fi

# 3. If SSH was found, process and print it
if [ -n "$SSH_CMD" ]; then
    
    # Extract Hostname
    ARGS=${SSH_CMD#*ssh }
    HOST="$ARGS"
    
    for arg in $ARGS; do
        if [[ "$arg" != -* ]]; then
            HOST="$arg"
            break 
        fi
    done
    
    if [[ "$HOST" == *"@"* ]]; then
        HOST=${HOST#*@}
    fi

    # Abbreviate
    if [ "$ABBR_LEN" -gt "0" ]; then
        if [ "${#HOST}" -gt "$ABBR_LEN" ]; then
             HOST="${HOST:0:$ABBR_LEN}.."
        fi
    fi

    # Output PILL
    output="$ICON ssh:$HOST"
    if [ "$SHOW_DIR" == "1" ]; then
        dir_name=$(basename "$DIR")
        output="$output $DIR_ICON $dir_name"
    fi

    echo "#[fg=$BG,bg=$BAR_BG]$L_SEP#[fg=$FG,bg=$BG,bold]$output#[fg=$BG,bg=$BAR_BG]$R_SEP "
else
    # Output NOTHING
    echo ""
fi
