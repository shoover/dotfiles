# Install all the dotfiles and run all the installer scripts.
#
# Pass the destination dir as an optional argument. Installs to $HOME by default.
#
# install.sh [DEST:$HOME] [all|dotfiles]
#
# Compliments to https://github.com/holman/dotfiles/blob/master/script/bootstrap

set -e
#set -x

DEST=$(realpath ${1:-$HOME})
selection=${2:all}

mkdir -p "$DEST"

DOTFILES=$(cd "$(dirname "$BASH_SOURCE")/.."; pwd -P)

#
# Install the files
#

function install_dotsymlinks {
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
}

function install_dotcopies {
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

if [ "$selection" == "all" ]; then
    install_scripts
fi
