#!/usr/bin/env bash
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "${script_dir}/../utils/ssh_detect.sh"

# extract_ssh_host is a pure function — no tmux needed
echo "basic: $(extract_ssh_host 'ssh host.example.com')"
echo "user@host: $(extract_ssh_host 'ssh user@host.example.com')"
echo "with flags: $(extract_ssh_host 'ssh -o StrictHostKeyChecking=no user@server.dev')"
echo "abbr 4: $(extract_ssh_host 'ssh long-hostname.example.com' 4)"
echo "abbr 0: $(extract_ssh_host 'ssh long-hostname.example.com' 0)"
echo "short no abbr: $(extract_ssh_host 'ssh ab' 10)"
