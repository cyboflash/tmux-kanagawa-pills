#!/usr/bin/env bash
# Helper functions for tests

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

print_option() {
  local opt="$1"
  local val
  val=$(tmux show-option -gqv "$opt")
  echo "${opt} ${val}"
}

print_env() {
  local var="$1"
  local val
  val=$(tmux show-environment -g "$var" 2>/dev/null | cut -d= -f2-)
  echo "${var} ${val}"
}

load_plugin() {
  tmux set-environment -g PLUGIN_DIR "$PLUGIN_DIR"
  source "$PLUGIN_DIR/kanagawa-pills.tmux"
}

load_plugin_with() {
  # Usage: load_plugin_with "@kanagawa_palette" "dragon" "@kanagawa_theme" "warm"
  while [ $# -ge 2 ]; do
    tmux set-option -g "$1" "$2"
    shift 2
  done
  load_plugin
}
