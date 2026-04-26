#!/usr/bin/env bash
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "${script_dir}/helpers.sh"

load_plugin

# Palette values (wave defaults)
print_env THM_BG_BASE
print_env THM_BG_SURFACE
print_env THM_FG_TEXT

# Role mappings (default theme)
print_env THM_ROLE_SESSION
print_env THM_ROLE_DIRECTORY
print_env THM_ROLE_SSH
print_env THM_ROLE_APP
print_env THM_ROLE_DATETIME
print_env THM_ROLE_BATTERY
print_env THM_ROLE_WEATHER
print_env THM_ROLE_MODULE_FG
print_env THM_ROLE_SESSION_FG

# Global options
print_option status-position
print_option status-justify
print_option status-style
print_option message-style
print_option pane-border-style
print_option pane-active-border-style
