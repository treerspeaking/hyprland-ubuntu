#!/usr/bin/env bash

HYPRLAND_UBUNTU_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)

for file in "$HYPRLAND_UBUNTU_DIR/current-hyprland-ubuntu/tmp"/*; do
    mv -f "$file" "$HYPRLAND_UBUNTU_DIR/current-hyprland-ubuntu/theme/"
done
