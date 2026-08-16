#!/usr/bin/env bash
# mymenu — an Omarchy-style nested menu built on `walker --dmenu`
#
# Usage:
#   menu            # open the top-level menu
#   menu style      # jump straight to a submenu
#
# Bind it in Hyprland:
#   bindd = SUPER ALT, space, My Menu, exec, ~/.local/bin/mymenu

set -uo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

BACK="󰌍  Back"

# ---------------------------------------------------------------- helpers ---

# strip <pango markup> and any leading icon glyphs / whitespace from a label,
# so "󰔎  Style" matches the plain string "Style" in a case statement.
strip() {
    sed -E 's/<[^>]+>//g; s/^[^[:alnum:]]*//; s/[[:space:]]+$//' <<<"$1"
}

# menu <prompt> <entry> [entry...]
# Prints the cleaned selection. Exits the whole script if the user hits Esc.
menu() {
    local prompt="$1"
    shift
    local choice
    # --theme is optional; see the styling note at the bottom of this file.
    choice=$(printf '%s\n' "$@" | walker --dmenu --minheight 1 --minwidth 260 --maxwidth 260 -p "$prompt" 2>/dev/null) || exit 0
    [[ -z $choice ]] && exit 0
    strip "$choice"
}

appmenu() {
    "$SCRIPT_DIR/appmenu.sh"
}

# run something detached so the menu process doesn't hold the app open
launch() { uwsm-app -- "$@" 2>/dev/null || setsid "$@" & }

# open a TUI in a floating terminal (adjust to your terminal of choice)
# tui() { launch kitty --class=Tui -e "$@"; }
tui() {
    xdg-terminal-exec --app-id=floating.terminal "$@"
}
# tui() { launch alacritty --class=Tui -e "$@"; }

# ------------------------------------------------------------------ menus ---

show_main() {
    case $(
        menu "Menu" \
            "󰀻  Apps" \
            "󰔎  Style" \
            "  System" \
            "󰐥  Power" \
            "󰉉  Install" \
            "󰭌  Remove" \
            "󰉁  Keybind"
    ) in
    Apps) appmenu ;;
    Style) show_style ;;
    System) show_system ;;
    Power) show_power ;;
    Install) install ;;
    Remove) remove ;;
    Keybind) remove ;;
    esac
}

show_style() {
    case $(menu "Style" \
        "󰸌  Theme" \
        "󰋩  Background" \
        "$BACK") in
    # these open Walker's own selectors rather than a dmenu list
    Theme) walker -m menus:omarchythemes ;;
    Background) walker -m menus:omarchyBackgroundSelector ;;
    Back) show_main ;;
    esac
}

show_system() {
    case $(menu "System" \
        "󰂯  Bluetooth" \
        "󰕾  Volume" \
        "󰖩  Wifi" \
        "$BACK") in
    Bluetooth) tui bluetui ;;
    Volume) tui wiremix ;;
    Wifi) tui impala ;;
    Back) show_main ;;
    esac
}

show_power() {
    case $(menu "Power" \
        "󰌾  Lock" \
        "󰍃  Logout" \
        "󰤄  Suspend" \
        "󰜉  Restart" \
        "󰐥  Shutdown" \
        "$BACK") in
    Lock) hyprlock ;;
    Logout) hyprctl dispatch 'hl.dsp.exit()' ;;
    Suspend) systemctl suspend ;;
    Restart) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
    Back) show_main ;;
    esac
}

install() {
    tui "$SCRIPT_DIR/install.sh"
}

remove() {
    tui "$SCRIPT_DIR/remove.sh"
}

toggle_existing_menu() {
    if pgrep -f "walker.*--dmenu" >/dev/null; then
        walker --close >/dev/null 2>&1
        exit 0
    fi
}

# --------------------------------------------------------------- dispatch ---

toggle_existing_menu

show_main

# case "${1:-}" in
# "") show_main ;;
# style) show_style ;;
# system) show_system ;;
# power) show_power ;;
# *)
#     echo "Unknown submenu: $1" >&2
#     exit 1
#     ;;
# esac
