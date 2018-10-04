# Install all the dotfiles and run all the installer scripts.
#
# Pass the destination dir as an optional argument. Installs to $HOME by default.
#
# install.sh [DEST:$HOME] [all|dotfiles]
#
# Compliments to https://github.com/holman/dotfiles/blob/master/script/bootstrap

set -e
#set -x

DEST=$(readlink -f ${1:-$HOME})
selection=${2:-all}

mkdir -p "$DEST"
mkdir -p "$DEST/bin"

DOTFILES=$(cd "$(dirname "$BASH_SOURCE")/.."; pwd -P)

#
# Install the files
#

function install_dotsymlinks {
    for src in $(find -H "$DOTFILES" -maxdepth 1 -name '*.ln' -not -path '*/.hg/*')
    do
        dst="$DEST/$(basename "${src%.*}")"
        if [ -L "$dst" ]; then
            echo Link "$dst" exists, skipping link
        elif [ -f "$dst" ]; then
            echo File "$dst" exists, skipping link
        else
            echo Linking "$dst"
            ln -s "$src" "$dst"
        fi
    done
}

function install_dotcopies {
    for src in $(find -H "$DOTFILES" -maxdepth 1 -name '*.cp' -not -path '*/.hg/*')
    do
        dst="$DEST/$(basename "${src%.*}")"
        if [ -f "$dst" ]; then
            echo File "$dst" exists, skipping copy
        elif [ -L "$dst" ]; then
            echo Link "$dst" exists, skipping copy
        else
            echo Copying "$dst"
            cp -n "$src" "$dst"
        fi
    done
}

function install_dest_bin {
    for src in $(find -H "$DOTFILES/bin" -maxdepth 1 -type f)
    do
        dst="$DEST/bin/$(basename "${src}")"
        if [ -L "$dst" ]; then
            echo Link "$dst" exists, skipping link
        elif [ -f "$dst" ]; then
            echo File "$dst" exists, skipping link
        else
            echo Linking "$dst"
            ln -s "$src" "$dst"
        fi
    done
}

#
# Run the installer scripts
#

function install_scripts {
    export DEST
    export DOTFILES
    find -H "$DOTFILES/init" -name "[0-9][0-9]-*.sh" | sort -n | while read script ; do
        echo ''
        echo Installing $script
        bash -x $script
    done
}

install_dotsymlinks
install_dotcopies
install_dest_bin

if [ "$selection" == "all" ]; then
    install_scripts
fi
