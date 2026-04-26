#!/usr/bin/env bash
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "${script_dir}/helpers.sh"

load_plugin

# Session pill (from status-left since session is default left plugin)
print_option status-left
