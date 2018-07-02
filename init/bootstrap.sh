#!/bin/bash

# ./bootstrap.sh [DEST|$HOME] [dotfiles|all]
# ./bootstrap.sh                  # default install files to HOME, run installers, clone repo
# ./bootstrap.sh $HOME dotfiles   # dotfiles only, no installers, no clone (no root)

dst=$(readlink -f ${1:-$HOME})
selection=${2:-all}

echo Bootstrap installing dotfiles to $dst

set -e
set -x

cd /tmp

wget -O dotfiles.tar.gz https://bitbucket.org/shoover/dotfiles/get/default.tar.gz
mkdir dotfiles
tar xzf dotfiles.tar.gz --strip 1 -C dotfiles

# Copy archive and install dotfiles only, for non-root, quick setup
if [ "$selection" == "dotfiles" ]
then
    cp -R dotfiles $dst/
    rm -rf /tmp/dotfiles
    cd $dst
    dotfiles/init/install.sh $dst $selection
    exit
fi

if [ "$selection" != "all" ]
then
    echo Invalid selection: $selection
    exit 1
fi

# Continue with hg checkout and package installation

bash -c dotfiles/init/00-platform.sh
bash -c dotfiles/init/01-hg.sh

rm -rf /tmp/dotfiles

mkdir -p $dst
cd $dst
hg clone ssh://hg@bitbucket.org/shoover/dotfiles
bash -x dotfiles/init/install.sh $dst
