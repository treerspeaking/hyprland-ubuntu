menu() {
    local prompt="$1"
    shift
    local choice
    # --theme is optional; see the styling note at the bottom of this file.
    choice=$(printf '%s\n' "$@" | walker --dmenu --minwidth 260 --maxwidth 260 -p "$prompt" 2>/dev/null) || exit 0
    [[ -z $choice ]] && exit 0
    strip "$choice"
}

hyprctl binds | 


