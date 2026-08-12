#!/usr/bin/env bash

set -e

BUILD_DIR="${BUILD_DIR:-$HOME/hyprbuntu}"

if ! command -v cargo &>/dev/null; then
    echo "Error: cargo not found. Run setup-hyprbuntu.sh first (it installs cargo), or install rustup yourself."
    exit 1
fi

# libgtk-4-dev/libgtk4-layer-shell-dev may need a PPA if apt's GTK4 is too old
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libgtk-4-dev \
    libgtk4-layer-shell-dev \
    libcairo2-dev \
    libpoppler-glib-dev \
    protobuf-compiler

mkdir -p "$BUILD_DIR"
if [ ! -d "$BUILD_DIR/walker" ]; then
    git clone https://github.com/abenz1267/walker.git "$BUILD_DIR/walker"
fi

cd "$BUILD_DIR/walker"
git fetch --tags
git checkout "$(git tag --sort=-v:refname | head -n 1)"

cargo build --release
sudo install -m 755 target/release/walker /usr/local/bin/walker

echo "walker installed to /usr/local/bin/walker"
