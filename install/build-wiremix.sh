#!/usr/bin/env bash

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y cargo libpipewire-0.3-dev pkg-config clang

cargo install wiremix
