#!/usr/bin/env bash
set -Euo pipefail
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "${script_dir}/tests/harness.sh"

run_test "${script_dir}/tests/default_options.sh" "${script_dir}/tests/default_options_expected.txt"
run_test "${script_dir}/tests/dragon_palette.sh" "${script_dir}/tests/dragon_palette_expected.txt"
run_test "${script_dir}/tests/theme_switching.sh" "${script_dir}/tests/theme_switching_expected.txt"
run_test "${script_dir}/tests/module_output.sh" "${script_dir}/tests/module_output_expected.txt"
run_test "${script_dir}/tests/ssh_detect.sh" "${script_dir}/tests/ssh_detect_expected.txt"

summary
