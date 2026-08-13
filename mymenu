#!/bin/bash
# mymenu — an Omarchy-style nested menu built on `walker --dmenu`
#
# Usage:
#   mymenu            # open the top-level menu
#   mymenu style      # jump straight to a submenu
#
# Bind it in Hyprland:
#   bindd = SUPER ALT, space, My Menu, exec, ~/.local/bin/mymenu

set -uo pipefail

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
    choice=$(printf '%s\n' "$@" | walker --dmenu -p "$prompt" 2>/dev/null) || exit 0
    [[ -z $choice ]] && exit 0
    strip "$choice"
}

# run something detached so the menu process doesn't hold the app open
launch() { uwsm app -- "$@" 2>/dev/null || setsid "$@" & }

# open a TUI in a floating terminal (adjust to your terminal of choice)
tui() { launch alacritty --class=Tui -e "$@"; }

# ------------------------------------------------------------------ menus ---

show_main() {
    case $(menu "Menu" \
        "󰀻  Apps" \
        "󰔎  Style" \
        "󰒓  System" \
        "󰐥  Power") in
    Apps) show_apps ;;
    Style) show_style ;;
    System) show_system ;;
    Power) show_power ;;
    esac
}

show_apps() {
    case $(menu "Apps" \
        "󰈹  Browser" \
        "󰆍  Terminal" \
        "󰉋  Files" \
        "$BACK") in
    Browser) launch brave ;;
    Terminal) launch alacritty ;;
    Files) launch nautilus ;;
    Back) show_main ;;
    esac
}

show_style() {
    case $(menu "Style" \
        "󰸌  Theme" \
        "󰋩  Background" \
        "󰛖  Font" \
        "$BACK") in
    # these open Walker's own selectors rather than a dmenu list
    Theme) walker -m menus:omarchythemes ;;
    Background) walker -m menus:omarchyBackgroundSelector ;;
    Font) omarchy-font-list ;;
    Back) show_main ;;
    esac
}

show_system() {
    case $(menu "System" \
        "󰚰  Update" \
        "󰑓  Restart Waybar" \
        "󰖩  Wifi" \
        "󰂯  Bluetooth" \
        "$BACK") in
    Update) tui omarchy-update ;;
    "Restart Waybar") omarchy-restart-waybar ;;
    Wifi) tui impala ;;
    Bluetooth) tui bluetui ;;
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
    Logout) hyprctl dispatch exit ;;
    Suspend) systemctl suspend ;;
    Restart) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
    Back) show_main ;;
    esac
}

# --------------------------------------------------------------- dispatch ---

case "${1:-}" in
"") show_main ;;
apps) show_apps ;;
style) show_style ;;
system) show_system ;;
power) show_power ;;
*)
    echo "Unknown submenu: $1" >&2
    exit 1
    ;;
esac

# ------------------------------------------------------------------ notes ---
#
# STYLING
#   Omarchy narrows the menu to a ~295px sidebar by passing a dedicated Walker
#   theme. Create ~/.config/walker/themes/mymenu/ (copy Omarchy's
#   ~/.local/share/omarchy/default/walker/themes/omarchy-default/ as a base),
#   set your width in style.css, then add `--theme mymenu` to the walker call
#   in menu(). Check `walker --help` first — flag names have moved between
#   versions.
#
# SPEED
#   Make sure walker is running as a service (walker --gapplication-service,
#   usually via ~/.config/autostart/walker.desktop on Omarchy). Cold-starting
#   walker on every nesting level feels sluggish.
#
# ICONS
#   The glyphs above are Nerd Font. strip() removes them before matching, so
#   you can change any icon without touching the case statements.
