#!/usr/bin/env bash

if pgrep -x waybar >/dev/null; then
    killall -e waybar
else
    uwsm-app -- waybar >/dev/null 2>&1 &
fi
