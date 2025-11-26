#!/bin/bash

set -e

# ./bootstrap.sh [DEST|$HOME] [dotfiles|all]
# ./bootstrap.sh                  # default install files to HOME, run installers, clone repo
# ./bootstrap.sh $HOME dotfiles   # dotfiles only, no installers, no clone (no root)

dst=$(readlink -f ${1:-$HOME})
selection=${2:-all}

ref=${GITHUB_REF:-refs/heads/main}
ref_name=${GITHUB_REF_NAME:-main}

echo Bootstrap installing dotfiles to $dst

set -x

cd /tmp

# Download a static archive to bootstrap.
wget -O dotfiles.tar.gz https://github.com/shoover/dotfiles/archive/${ref}.tar.gz
rm -rf dotfiles
mkdir dotfiles
tar xzf dotfiles.tar.gz --strip 1 -C dotfiles

# Copy archive and install dotfiles only, for quick setup and no checkout
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
    echo Unrecognized selection: $selection
    exit 1
fi

bash -c dotfiles/init/00-platform.sh
bash -c dotfiles/init/01-git.sh

rm -rf /tmp/dotfiles

# Clone the repo and install everything.
mkdir -p $dst
cd $dst
git clone https://github.com/shoover/dotfiles.git
cd dotfiles
git checkout ${ref_name}
bash -x init/install.sh $dst
