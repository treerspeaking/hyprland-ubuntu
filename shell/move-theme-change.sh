#!/usr/bin/env bash

OMARCHY_UBUNTU_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../ && pwd)

for file in "$OMARCHY_UBUNTU_DIR/current-omarchy-ubuntu/tmp"/*; do
    mv -f "$file" "$OMARCHY_UBUNTU_DIR/current-omarchy-ubuntu/theme/"
done
