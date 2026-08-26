#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HYPRLAND_UBUNTU_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)

background_img_dir="${1#"$HOME"}"

ln -sfn "$1" "$HYPRLAND_UBUNTU_DIR/current-hyprland-ubuntu/tmp/background-img"

printf "%s\n" "$background_img_dir" >"$HYPRLAND_UBUNTU_DIR/current-hyprland-ubuntu/tmp/current-background.name"

"$SCRIPT_DIR/move-theme-change.sh"

hyprctl hyprpaper wallpaper ",$(readlink -f "$HYPRLAND_UBUNTU_DIR/current-hyprland-ubuntu/theme/background-img")"
