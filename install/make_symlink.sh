#!/usr/bin/env bash

set -e

if [ -d "$HOME/.config/hypr" ] && [ ! -L "$HOME/.config/hypr" ]; then
    mv "$HOME/.config/hypr" "$HOME/.config/hypr.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn ~/.local/share/hyprland-ubuntu/hypr ~/.config/hypr

if [ -d "$HOME/.config/waybar" ] && [ ! -L "$HOME/.config/waybar" ]; then
    mv "$HOME/.config/waybar" "$HOME/.config/waybar.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn ~/.local/share/hyprland-ubuntu/waybar ~/.config/waybar

if [ -d "$HOME/.config/elephant" ] && [ ! -L "$HOME/.config/elephant" ]; then
    mv "$HOME/.config/elephant" "$HOME/.config/elephant.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn ~/.local/share/hyprland-ubuntu/elephant ~/.config/elephant

if [ -d "$HOME/.config/walker" ] && [ ! -L "$HOME/.config/walker" ]; then
    mv "$HOME/.config/walker" "$HOME/.config/walker.bak.$(date +%Y%m%d_%H%M%S)"
fi

ln -sfn ~/.local/share/hyprland-ubuntu/walker ~/.config/walker
