HYPRLAND_UBUNTU_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)
TEMP_DIR="$HYPRLAND_UBUNTU_DIR/current-hyprland-ubuntu/tmp"

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
done <"$HYPRLAND_UBUNTU_DIR/themes/$1/colors.toml"

cat >"$TEMP_DIR/colors.lua" <<-EOF
return {
    mode = "$mode",

    accent = "$selection",
    selection = "$muted",
    muted = "$muted",

    background = "$background",
    dark_background = "$dark_background",
    darker_background = "$darker_background",
    lighter_background = "$lighter_background",

    foreground = "$foreground",
    dark_foreground = "$dark_foreground",
    light_foreground = "$light_foreground",
    bright_foreground = "$green",

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
