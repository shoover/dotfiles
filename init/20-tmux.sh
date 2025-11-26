#!/bin/bash

set -e

# Install from source to support specific syntax.
if ! [ -x "$(command -v tmux)" ]; then
    # https://gist.github.com/P7h/91e14096374075f5316e
    VERSION=2.6

    pushd /tmp

    sudo apt-get -y install wget tar libevent-dev libncurses-dev
    wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
    tar xf tmux-${VERSION}.tar.gz
    rm -f tmux-${VERSION}.tar.gz
    cd tmux-${VERSION}
    ./configure
    make
    sudo make install
    cd -
    sudo rm -rf /usr/local/src/tmux-*
    sudo mv tmux-${VERSION} /usr/local/src

    popd
fi
