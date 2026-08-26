#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/create-theme.sh" "$1" || exit 1

"$SCRIPT_DIR/move-theme-change.sh" "$1" || exit 1

# reload kitty
kill -SIGUSR1 $(pgrep kitty)
# reload hyprland
hyprctl reload
# killall -e waybar && uwsm-app -- waybar >/dev/null 2>&1 &
