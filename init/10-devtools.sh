#!/bin/bash

set -e

#
# The text editor. Full package for desktop, -nox for servers.
#
if ! [ -x "$(command -v emacs)" ]; then
    # Install the copious emacs build deps, with NO prompt for postfix config
    sudo DEBIAN_FRONTEND=noninteractive apt-get build-dep -yq emacs

    sudo apt-get install -y gnutls-bin gnutls-dev

    pushd /tmp

    emacs=emacs-29.1
    wget http://ftpmirror.gnu.org/emacs/$emacs.tar.xz
    tar xf $emacs.tar.xz

    pushd $emacs
    ./autogen.sh
    ./configure
    make -j$(proc)
    sudo make install
    popd

    rm -f $emacs.tar.xz
    rm -rf $emacs

    popd
fi

#
# Python
#
sudo apt-get install -y python3 python3-dev python3-pip

#
# Ruby
#
sudo apt-get install -y ruby ruby-dev

# Don't spend time installing gem CLI docs
grep no-document ~/.gemrc > /dev/null 2>&1 || echo "gem: --no-document" >> ~/.gemrc

if ! gem spec ffi > /dev/null 2>&1; then
    sudo gem install ffi
fi

#
# Source control
#
pip3 install --user --upgrade mercurial
sudo apt-get install -y subversion
