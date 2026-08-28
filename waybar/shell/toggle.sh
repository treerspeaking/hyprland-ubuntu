#!/usr/bin/env bash

# if pgrep -x waybar >/dev/null; then
#     killall -e waybar
# else
#     uwsm-app -- waybar >/dev/null 2>&1 &
# fi
#
if systemctl --user --quiet is-active waybar; then
    systemctl --user stop waybar
else
    systemctl --user start waybar
fi
