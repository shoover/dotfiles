#!/bin/bash

set -e

# Installing from source seems to make the keybindings work better than from apt.
FZF="$DEST/.fzf"

if ! [ -d $(readlink -f "$FZF") ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZF
fi

git -C $FZF pull
$FZF/install --all
