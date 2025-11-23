#!/bin/bash

set -e

function command_exists {
    command -v "$1" >/dev/null 2>&1
}

# https://brew.sh
if ! command_exists brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo Homebrew is already installed. Skipping.
fi

brew install direnv iterm2 tmux tree
