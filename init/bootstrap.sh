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

# Download a static archive to bootstrap.
wget -O dotfiles.tar.gz https://code.shawnhoover.dev/dotfiles/archive/tip.tar.gz
rm -rf dotfiles
mkdir dotfiles
tar xzf dotfiles.tar.gz --strip 1 -C dotfiles

# Copy archive and install dotfiles only, for quick setup and no hg
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

# Bootstrap tools to set up an hg working copy.
bash -c dotfiles/init/00-platform.sh
bash -c dotfiles/init/01-hg.sh

# It's too soon to source .bashrc, but we need hg on the PATH.
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

rm -rf /tmp/dotfiles

# Clone the repo and install everything.
mkdir -p $dst
cd $dst
hg clone https://code.shawnhoover.dev/dotfiles
bash -x dotfiles/init/install.sh $dst
