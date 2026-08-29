#!/usr/bin/env bash

OMARCHY_UBUNTU_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)
TEMP_DIR="$OMARCHY_UBUNTU_DIR/current-omarchy-ubuntu/tmp"
THEME_NAME="$1"
THEME_DIR="$OMARCHY_UBUNTU_DIR/themes/$THEME_NAME"

if [[ ! -f "$THEME_DIR/colors.toml" ]]; then
    echo "set-theme.sh: no such theme '$THEME_NAME'" >&2
    exit 1
fi

if [[ ! -d "$TEMP_DIR" ]]; then
    mkdir -p "$TEMP_DIR"
fi

mode_re='^[[:space:]]*mode[[:space:]]*=[[:space:]]*"([^"]*)"'

accent_re='^[[:space:]]*accent[[:space:]]*=[[:space:]]*"([^"]*)"'
selection_re='^[[:space:]]*selection[[:space:]]*=[[:space:]]*"([^"]*)"'
muted_re='^[[:space:]]*muted[[:space:]]*=[[:space:]]*"([^"]*)"'

background_re='^[[:space:]]*background[[:space:]]*=[[:space:]]*"([^"]*)"'
dark_background_re='^[[:space:]]*dark_background[[:space:]]*=[[:space:]]*"([^"]*)"'
darker_background_re='^[[:space:]]*darker_background[[:space:]]*=[[:space:]]*"([^"]*)"'
lighter_background_re='^[[:space:]]*lighter_background[[:space:]]*=[[:space:]]*"([^"]*)"'

foreground_re='^[[:space:]]*foreground[[:space:]]*=[[:space:]]*"([^"]*)"'
dark_foreground_re='^[[:space:]]*dark_foreground[[:space:]]*=[[:space:]]*"([^"]*)"'
light_foreground_re='^[[:space:]]*light_foreground[[:space:]]*=[[:space:]]*"([^"]*)"'
bright_foreground_re='^[[:space:]]*bright_foreground[[:space:]]*=[[:space:]]*"([^"]*)"'

red_re='^[[:space:]]*red[[:space:]]*=[[:space:]]*"([^"]*)"'
yellow_re='^[[:space:]]*yellow[[:space:]]*=[[:space:]]*"([^"]*)"'
orange_re='^[[:space:]]*orange[[:space:]]*=[[:space:]]*"([^"]*)"'
green_re='^[[:space:]]*green[[:space:]]*=[[:space:]]*"([^"]*)"'
cyan_re='^[[:space:]]*cyan[[:space:]]*=[[:space:]]*"([^"]*)"'
blue_re='^[[:space:]]*blue[[:space:]]*=[[:space:]]*"([^"]*)"'
magenta_re='^[[:space:]]*magenta[[:space:]]*=[[:space:]]*"([^"]*)"'
brown_re='^[[:space:]]*brown[[:space:]]*=[[:space:]]*"([^"]*)"'

bright_red_re='^[[:space:]]*bright_red[[:space:]]*=[[:space:]]*"([^"]*)"'
bright_yellow_re='^[[:space:]]*bright_yellow[[:space:]]*=[[:space:]]*"([^"]*)"'
bright_green_re='^[[:space:]]*bright_green[[:space:]]*=[[:space:]]*"([^"]*)"'
bright_cyan_re='^[[:space:]]*bright_cyan[[:space:]]*=[[:space:]]*"([^"]*)"'
bright_blue_re='^[[:space:]]*bright_blue[[:space:]]*=[[:space:]]*"([^"]*)"'
bright_magenta_re='^[[:space:]]*bright_magenta[[:space:]]*=[[:space:]]*"([^"]*)"'

while IFS= read -r line; do
    if [[ $line =~ $mode_re ]]; then
        mode="${BASH_REMATCH[1]}"
    elif [[ $line =~ $accent_re ]]; then
        accent="${BASH_REMATCH[1]}"
    elif [[ $line =~ $selection_re ]]; then
        selection="${BASH_REMATCH[1]}"
    elif [[ $line =~ $muted_re ]]; then
        muted="${BASH_REMATCH[1]}"
    elif [[ $line =~ $background_re ]]; then
        background="${BASH_REMATCH[1]}"
    elif [[ $line =~ $dark_background_re ]]; then
        dark_background="${BASH_REMATCH[1]}"
    elif [[ $line =~ $darker_background_re ]]; then
        darker_background="${BASH_REMATCH[1]}"
    elif [[ $line =~ $lighter_background_re ]]; then
        lighter_background="${BASH_REMATCH[1]}"
    elif [[ $line =~ $foreground_re ]]; then
        foreground="${BASH_REMATCH[1]}"
    elif [[ $line =~ $dark_foreground_re ]]; then
        dark_foreground="${BASH_REMATCH[1]}"
    elif [[ $line =~ $light_foreground_re ]]; then
        light_foreground="${BASH_REMATCH[1]}"
    elif [[ $line =~ $bright_foreground_re ]]; then
        bright_foreground="${BASH_REMATCH[1]}"
    elif [[ $line =~ $red_re ]]; then
        red="${BASH_REMATCH[1]}"
    elif [[ $line =~ $yellow_re ]]; then
        yellow="${BASH_REMATCH[1]}"
    elif [[ $line =~ $orange_re ]]; then
        orange="${BASH_REMATCH[1]}"
    elif [[ $line =~ $green_re ]]; then
        green="${BASH_REMATCH[1]}"
    elif [[ $line =~ $cyan_re ]]; then
        cyan="${BASH_REMATCH[1]}"
    elif [[ $line =~ $blue_re ]]; then
        blue="${BASH_REMATCH[1]}"
    elif [[ $line =~ $magenta_re ]]; then
        magenta="${BASH_REMATCH[1]}"
    elif [[ $line =~ $brown_re ]]; then
        brown="${BASH_REMATCH[1]}"
    elif [[ $line =~ $bright_red_re ]]; then
        bright_red="${BASH_REMATCH[1]}"
    elif [[ $line =~ $bright_yellow_re ]]; then
        bright_yellow="${BASH_REMATCH[1]}"
    elif [[ $line =~ $bright_green_re ]]; then
        bright_green="${BASH_REMATCH[1]}"
    elif [[ $line =~ $bright_cyan_re ]]; then
        bright_cyan="${BASH_REMATCH[1]}"
    elif [[ $line =~ $bright_blue_re ]]; then
        bright_blue="${BASH_REMATCH[1]}"
    elif [[ $line =~ $bright_magenta_re ]]; then
        bright_magenta="${BASH_REMATCH[1]}"
    fi
done <"$THEME_DIR/colors.toml"

cat >"$TEMP_DIR/colors.lua" <<EOF
return {
	mode = "$mode",

	accent = "$accent",
	selection = "$selection",
	muted = "$muted",

	background = "$background",
	dark_background = "$dark_background",
	darker_background = "$darker_background",
	lighter_background = "$lighter_background",

	foreground = "$foreground",
	dark_foreground = "$dark_foreground",
	light_foreground = "$light_foreground",
	bright_foreground = "$bright_foreground",

	red = "$red",
	yellow = "$yellow",
	orange = "$orange",
	green = "$green",
	cyan = "$cyan",
	blue = "$blue",
	magenta = "$magenta",
	brown = "$brown",

	bright_red = "$bright_red",
	bright_yellow = "$bright_yellow",
	bright_green = "$bright_green",
	bright_cyan = "$bright_cyan",
	bright_blue = "$bright_blue",
	bright_magenta = "$bright_magenta",
}
EOF

cat >"$TEMP_DIR/kitty-theme.conf" <<EOF
foreground $foreground
background $background
selection_foreground $foreground
selection_background $selection

cursor $foreground
cursor_text_color $background

active_border_color $accent
active_tab_background $accent

color0 $background
color1 $red
color2 $green
color3 $yellow
color4 $blue
color5 $magenta
color6 $cyan
color7 $foreground
color8 $dark_foreground
color9 $bright_red
color10 $bright_green
color11 $bright_yellow
color12 $bright_blue
color13 $bright_magenta
color14 $bright_cyan
color15 $bright_foreground
EOF

cat >"$TEMP_DIR/waybar.css" <<EOF
@define-color foreground $foreground;
@define-color background $background;
EOF

cat >"$TEMP_DIR/walker.css" <<EOF
@define-color selected-text $accent;
@define-color text $foreground;
@define-color base $background;
@define-color border $foreground;
@define-color foreground $foreground;
@define-color background $background;
EOF

cat >"$TEMP_DIR/mako.ini" <<EOF
include=~/.config/mako/core.ini

text-color=$foreground
border-color=$accent
background-color=$background
EOF

# A theme may ship its own btop.theme; only generate one when it doesn't
if [[ -f "$THEME_DIR/btop.theme" ]]; then
    cp -f "$THEME_DIR/btop.theme" "$TEMP_DIR/btop.theme"
else
    cat >"$TEMP_DIR/btop.theme" <<EOF
# Main background, empty for terminal default, need to be empty if you want transparent background
theme[main_bg]="$background"

# Main text color
theme[main_fg]="$foreground"

# Title color for boxes
theme[title]="$foreground"

# Highlight color for keyboard shortcuts
theme[hi_fg]="$accent"

# Background color of selected item in processes box
theme[selected_bg]="$selection"

# Foreground color of selected item in processes box
theme[selected_fg]="$accent"

# Color of inactive/disabled text
theme[inactive_fg]="$muted"

# Color of text appearing on top of graphs, i.e uptime and current network graph scaling
theme[graph_text]="$light_foreground"

# Background color of the percentage meters
theme[meter_bg]="$selection"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
theme[proc_misc]="$light_foreground"

# CPU, Memory, Network, Proc box outline colors
theme[cpu_box]="$magenta"
theme[mem_box]="$green"
theme[net_box]="$red"
theme[proc_box]="$accent"

theme[cpu_box]="$green"
theme[mem_box]="$yellow"
theme[net_box]="$magenta"
theme[proc_box]="$red"

# Box divider line and small boxes line color
theme[div_line]="$muted"

# Temperature graph color (Green -> Yellow -> Red)
theme[temp_start]="$green"
theme[temp_mid]="$yellow"
theme[temp_end]="$red"

# CPU graph colors (Teal -> Blue -> Magenta)
theme[cpu_start]="$cyan"
theme[cpu_mid]="$blue"
theme[cpu_end]="$magenta"

# Mem/Disk free meter
theme[free_start]="$magenta"
theme[free_mid]="$blue"
theme[free_end]="$cyan"

# Mem/Disk cached meter
theme[cached_start]="$blue"
theme[cached_mid]="$cyan"
theme[cached_end]="$magenta"

# Mem/Disk available meter
theme[available_start]="$yellow"
theme[available_mid]="$red"
theme[available_end]="$red"

# Mem/Disk used meter (Green -> Teal -> Blue)
theme[used_start]="$green"
theme[used_mid]="$cyan"
theme[used_end]="$blue"

# Download graph colors
theme[download_start]="$yellow"
theme[download_mid]="$red"
theme[download_end]="$red"

# Upload graph colors (Green -> Teal -> Blue)
theme[upload_start]="$green"
theme[upload_mid]="$cyan"
theme[upload_end]="$blue"

# Process box color gradient for threads, mem and cpu usage
theme[process_start]="$cyan"
theme[process_mid]="$blue"
theme[process_end]="$magenta"

# Graph gradient colors (spectrum shades from background to foreground)
theme[gradient_color_0]="$background"
theme[gradient_color_1]="$lighter_background"
theme[gradient_color_2]="$selection"
theme[gradient_color_3]="$muted"
theme[gradient_color_4]="$dark_foreground"
theme[gradient_color_5]="$foreground"
theme[gradient_color_6]="$light_foreground"
theme[gradient_color_7]="$bright_foreground"
EOF
fi

cat >"$TEMP_DIR/current-theme.name" <<EOF
$THEME_NAME
EOF
