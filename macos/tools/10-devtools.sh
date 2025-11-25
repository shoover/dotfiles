#!/bin/bash

set -e

brew install git gh

if [ -d /Applications/Emacs.app ]; then
    echo "/Applications/Emacs.app is already installed. Skipping."
else
    brew install emacs-app
fi

brew install sqlite3 duckdb

brew install python3 uv

brew install pandoc

function command_exists {
    command -v "$1" >/dev/null 2>&1
}

if command_exists docker; then
    echo "docker is already installed. Skipping."
else
    brew install --cask docker-desktop
    brew install docker docker-buildx
fi
