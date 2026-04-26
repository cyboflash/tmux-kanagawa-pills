#!/usr/bin/env bash
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "${script_dir}/helpers.sh"

load_plugin_with "@kanagawa_palette" "dragon"

print_env THM_BG_BASE
print_env THM_BG_SURFACE
print_env THM_FG_TEXT
print_env THM_ROLE_SESSION
print_env THM_ROLE_DIRECTORY
print_env THM_ROLE_SSH
