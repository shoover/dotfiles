#!/bin/bash

set -e

pushd $DEST

if ! [ -d "emacs" ]; then
    git clone https://github.com/shoover/emacs.d.git emacs
fi

emacs --load emacs/bootstrap.el --batch --funcall my-bootstrap-packages

popd
