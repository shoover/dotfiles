pushd $DEST

if ! [ -d "emacs" ]; then
    hg clone https://code.shawnhoover.dev/emacs.d emacs
fi

emacs --load emacs/bootstrap.el --batch --funcall my-bootstrap-packages

popd
