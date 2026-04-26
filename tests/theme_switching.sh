#!/usr/bin/env bash
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "${script_dir}/helpers.sh"

load_plugin_with "@kanagawa_theme" "warm"

print_env THM_ROLE_SESSION
print_env THM_ROLE_DIRECTORY
print_env THM_ROLE_SSH
print_env THM_ROLE_ACTIVE_BG
