#!/bin/bash

# Install all the dotfiles and run all the installer scripts.
#
# Pass the destination dir as an optional argument. Installs to $HOME by default.
#
# install.sh [DEST:$HOME] [all|dotfiles]
#
# Compliments to https://github.com/holman/dotfiles/blob/master/script/bootstrap

set -e
set -x

DEST=$(readlink -f ${1:-$HOME})
selection=${2:-all}

mkdir -p "$DEST"
mkdir -p "$DEST/bin"

DOTFILES=$(cd "$(dirname "$BASH_SOURCE")/.."; pwd -P)

#
# Helpers
#

info () {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

# Symbolic link with override/backup/skip prompt for existing files.
# Something is needed even for new users since .bashrc typically exists by default.
link_file () {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then

        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
        then

            local currentSrc="$(readlink $dst)"

            if [ "$currentSrc" == "$src" ]
            then

                skip=true;

            else

                user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                read -n 1 action

                case "$action" in
                    o )
                        overwrite=true;;
                    O )
                        overwrite_all=true;;
                    b )
                        backup=true;;
                    B )
                        backup_all=true;;
                    s )
                        skip=true;;
                    S )
                        skip_all=true;;
                    * )
                    ;;
                esac

            fi

        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

        if [ "$overwrite" == "true" ]
        then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [ "$backup" == "true" ]
        then
            mv "$dst" "${dst}.backup"
            success "moved $dst to ${dst}.backup"
        fi

        if [ "$skip" == "true" ]
        then
            success "skipped $src"
        fi
    fi

    if [ "$skip" != "true" ]  # "false" or empty
    then
        ln -s "$src" "$dst"
        success "linked $src to $dst"
    fi
}

#
# Install the files
#

function install_dotsymlinks {
    local overwrite_all=${overwrite_all:-false}
    local backup_all=${backup_all:-false}
    local skip_all=${skip_all:-false}

    for src in $(find -H "$DOTFILES" -maxdepth 1 -name '*.ln' -not -path '*/.hg/*')
    do
        dst="$DEST/$(basename "${src%.*}")"
        link_file "$src" "$dst"
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
