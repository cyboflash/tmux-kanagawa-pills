#!/usr/bin/env bash
set -Euo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

SOCKET_NAME="kanagawa-test-$$"
SESSION_NAME="test"
PASS=0
FAIL=0

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

tmux() { command tmux -L "$SOCKET_NAME" -f /dev/null "$@"; }

start_tmux() {
  tmux new-session -d -s "$SESSION_NAME" "$(which bash)"
  sleep 0.2
}

kill_tmux() { tmux kill-server 2>/dev/null || true; }

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  kill_tmux
}

run_test() {
  local test_script="$1"
  local expected_file="$2"
  local test_name
  test_name=$(basename "$test_script" .sh)

  start_tmux

  local output
  output=$(source "$test_script" 2>&1) || {
    echo -e "${RED}FAIL${NC} ${test_name} (script error)"
    FAIL=$((FAIL + 1))
    kill_tmux
    return
  }

  kill_tmux

  if echo "$output" | diff -abB "$expected_file" - > /dev/null 2>&1; then
    echo -e "${GREEN}PASS${NC} ${test_name}"
    PASS=$((PASS + 1))
  else
    echo -e "${RED}FAIL${NC} ${test_name}"
    echo "  Expected:"
    sed 's/^/    /' "$expected_file"
    echo "  Got:"
    echo "$output" | sed 's/^/    /'
    FAIL=$((FAIL + 1))
  fi
}

summary() {
  echo ""
  echo "$((PASS + FAIL)) tests, ${PASS} passed, ${FAIL} failed"
  [ "$FAIL" -eq 0 ]
}
