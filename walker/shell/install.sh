#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/ask_sudo.sh"

pkg_names=$(apt-cache search . | fzf -m | awk '{print $1}')

if [[ -n $pkg_names ]]; then
    ask_for_sudo
    sudo apt-get install -y "$pkg_names"
fi

read -rn 1 -s -p "Press any key..."

exit 0
