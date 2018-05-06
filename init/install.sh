# Install all the dotfiles and run all the installer scripts.
#
# Pass the destination dir as an optional argument. Installs to $HOME by default.
#
# Compliments to https://github.com/holman/dotfiles/blob/master/script/bootstrap

set -e
#set -x

DEST=$(realpath ${1:-$HOME})
mkdir -p "$DEST"

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

#
# Install the files
#

# symlinks
for src in $(find -H "$DOTFILES" -maxdepth 1 -name '*.ln' -not -path '*/.hg/*')
do
    dst="$DEST/$(basename "${src%.*}")"
    if [ -L "$dst" ]; then
        echo Link "$dst" exists
    else
        echo Linking "$dst"
        ln -s "$src" "$dst"
    fi
done

# copies
for src in $(find -H "$DOTFILES" -maxdepth 1 -name '*.cp' -not -path '*/.hg/*')
do
    dst="$DEST/$(basename "${src%.*}")"
    if [ -f "$dst" ]; then
        echo Copy "$dst" exists
    else
        echo Copying "$dst"
        cp -n "$src" "$dst"
    fi
done

#
# Run the installer scripts
#
export DEST
export DOTFILES
find . -name "[0-9][0-9]-*.sh" | sort -n | while read script ; do
    echo ''
    echo Installing $script
    bash -c "${script}"
done
