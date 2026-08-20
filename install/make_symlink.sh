#!/usr/bin/env bash

HYPRLAND_UBUNTU_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)

# Maybe in the future add a flag to allow for back up the symlink too
set -e

if [ -d "$HOME/.config/hypr" ] && [ ! -L "$HOME/.config/hypr" ]; then
    mv "$HOME/.config/hypr" "$HOME/.config/hypr.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn "$HYPRLAND_UBUNTU_DIR/hypr" ~/.config/hypr

if [ -d "$HOME/.config/waybar" ] && [ ! -L "$HOME/.config/waybar" ]; then
    mv "$HOME/.config/waybar" "$HOME/.config/waybar.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn "$HYPRLAND_UBUNTU_DIR/waybar" ~/.config/waybar

if [ -d "$HOME/.config/elephant" ] && [ ! -L "$HOME/.config/elephant" ]; then
    mv "$HOME/.config/elephant" "$HOME/.config/elephant.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn "$HYPRLAND_UBUNTU_DIR/elephant" ~/.config/elephant

if [ -d "$HOME/.config/walker" ] && [ ! -L "$HOME/.config/walker" ]; then
    mv "$HOME/.config/walker" "$HOME/.config/walker.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn "$HYPRLAND_UBUNTU_DIR/walker" ~/.config/walker

if [ -d "$HOME/.config/current-hyprland-ubuntu" ] && [ ! -L "$HOME/.config/current-hyprland-ubuntu" ]; then
    mv "$HOME/.config/current-hyprland-ubuntu" "$HOME/.config/current-hyprland-ubuntu.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn "$HYPRLAND_UBUNTU_DIR/current-hyprland-ubuntu" ~/.config/current-hyprland-ubuntu

if [ -e "$HOME/.config/systemd/user/walker.service" ] && [ ! -L "$HOME/.config/systemd/user/walker.service" ]; then
    mv "$HOME/.config/systemd/user/walker.service" "$HOME/.config/systemd/user/walker.service.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn "$HYPRLAND_UBUNTU_DIR/walker/service/walker.service" ~/.config/systemd/user/walker.service
