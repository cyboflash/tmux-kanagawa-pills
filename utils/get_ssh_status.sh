#!/usr/bin/env bash

PID=$1
ABBR_LEN=$2
COLOR=$3
TEXT_COLOR=$4
BAR_BG=$5
L_SEP=$6
R_SEP=$7
ICON=$8

# 1. Get the command
if [ "$(uname)" == "Darwin" ]; then
  CMD=$(ps -o command= -p "$PID" 2>/dev/null)
else
  CMD=$(ps -o args= -p "$PID" 2>/dev/null)
fi

# 2. Check for SSH
if [[ "$CMD" =~ (^|/)ssh([[:space:]]|$) ]]; then

    # 3. Extract Hostname
    ARGS=${CMD#*ssh }
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

    # 4. Abbreviate
    if [ "$ABBR_LEN" -gt "0" ]; then
        if [ "${#HOST}" -gt "$ABBR_LEN" ]; then
             HOST="${HOST:0:$ABBR_LEN}.."
        fi
    fi

    # 5. Output FULL FORMATTED PILL
    # Format: #[fg=COLOR,bg=BAR]LeftSep#[fg=TEXT,bg=COLOR]Icon ssh:Host#[fg=COLOR,bg=BAR]RightSep Spacer
    echo "#[fg=$COLOR,bg=$BAR_BG]$L_SEP#[fg=$TEXT_COLOR,bg=$COLOR,bold]$ICON ssh:$HOST#[fg=$COLOR,bg=$BAR_BG]$R_SEP "
else
    # 6. Not SSH? Output NOTHING.
    echo ""
fi
