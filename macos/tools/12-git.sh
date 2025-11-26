#!/bin/bash
# Create .gitconfig.local to allow setting a machine-specific email interactively.

set -e

config_path="$DEST/.gitconfig.local"
default_email=shawn@shawnhoover.dev

if [ -f "$config_path" ]; then
  echo "$config_path already exists. Skipping."
  exit 0
fi

email=
if [ -t 0 ]; then
  read -r -p "Preferred git email [${default_email}]: " email
else
  echo "No TTY available to read preferred git email. Using default."
fi

if [ -z "$email" ]; then
    email=$default_email
fi

echo "Configuring email ${email}"

cat > "$config_path" <<CONF
[user]
	name = Shawn Hoover
	email = ${email}
CONF
