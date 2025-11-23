#!/bin/bash

set -e

if [ -z "$ZSH" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo zsh is already configured: "$ZSH". Skipping.
fi
