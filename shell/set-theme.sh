HYPRLAND_UBUNTU_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)

while IFS= read -r line; do
    printf '%s\n' "$line"
done <"$HYPRLAND_UBUNTU_DIR/themes/$1/colors.toml"
