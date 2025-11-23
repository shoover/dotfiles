#!/bin/bash

set -e

brew install git gh

if [ -d /Applications/Emacs.app ]; then
  echo "/Applications/Emacs.app already exists. Skipping."
else
  brew install emacs-app
fi

brew install sqlite3 duckdb

brew install python3 uv

brew install pandoc
