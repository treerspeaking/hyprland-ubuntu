#!/usr/bin/env bash

keybind=""
description=""
while read -r line; do
    if [[ "$line" == *"modmask:"* ]]; then
        modmask="${line##*"modmask: "}"
        split=([1]="Shift" [2]="Caps" [4]="Ctrl" [8]="Alt" [16]="NumLock" [32]="Mod3" [64]="Super" [128]="Mod5")
        for i in "${!split[@]}"; do
            if ((modmask & i)); then
                keybind+="${split[$i]} + "
            fi
        done
    fi

    if [[ "$line" == *"key:"* ]]; then
        key="${line##*"key: "}"

        case $key in
        mouse:272) key="Left Mouse Button" ;;
        mouse:273) key="Right Mouse Button" ;;
        esac

        keybind+="$key"
    fi

    if [[ "$line" == *"description:"* ]]; then
        description="${line##*"description: "}"
        printf "%-35s → %s \n" "$keybind" "$description"
        keybind=""
        description=""
    fi

    # keybinds+=("$keybinditem")

done < <(hyprctl binds) | walker --dmenu --minheight 1 --width 900 --height 700 -p "Search Keybinds" 2>/dev/null
