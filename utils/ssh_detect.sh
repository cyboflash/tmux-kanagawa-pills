#!/usr/bin/env bash

# Shared SSH detection — single source of truth
check_pid_for_ssh() {
    local check_pid=$1
    if [ "$(uname)" == "Darwin" ]; then
        local cmd=$(ps -o command= -p "$check_pid" 2>/dev/null)
    else
        local cmd=$(ps -o args= -p "$check_pid" 2>/dev/null)
    fi
    if [[ "$cmd" =~ (^|/)ssh([[:space:]]|$) ]]; then
        echo "$cmd"
        return 0
    fi
    return 1
}

# Check pane PID and its children for an SSH session.
# Prints the ssh command string if found, empty otherwise.
find_ssh_cmd() {
    local pid=$1
    local ssh_cmd
    ssh_cmd=$(check_pid_for_ssh "$pid")
    if [ -n "$ssh_cmd" ]; then
        echo "$ssh_cmd"
        return 0
    fi
    local child
    for child in $(pgrep -P "$pid"); do
        ssh_cmd=$(check_pid_for_ssh "$child")
        if [ -n "$ssh_cmd" ]; then
            echo "$ssh_cmd"
            return 0
        fi
    done
    return 1
}

# Extract hostname from an ssh command string, optionally abbreviate.
# Usage: extract_ssh_host "ssh -o Foo user@host.example.com" [max_len]
extract_ssh_host() {
    local ssh_cmd=$1
    local abbr_len=${2:-0}
    local args=${ssh_cmd#*ssh }
    local host=""
    local skip_next=false
    for arg in $args; do
        if $skip_next; then
            skip_next=false
            continue
        fi
        # Flags that consume the next argument
        if [[ "$arg" =~ ^-[bcDEeFIiJLlmOopQRSWw]$ ]]; then
            skip_next=true
            continue
        fi
        if [[ "$arg" == -* ]]; then
            continue
        fi
        host="$arg"
        break
    done
    host=${host#*@}
    if [ "$abbr_len" -gt 0 ] && [ "${#host}" -gt "$abbr_len" ]; then
        host="${host:0:$abbr_len}.."
    fi
    echo "$host"
}
