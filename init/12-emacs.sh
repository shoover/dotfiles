pushd $DEST

if ! [ -d "emacs" ]; then
    hg clone https://bitbucket.org/shoover/emacs.d emacs
fi

emacs --load emacs/bootstrap.el --batch --funcall my-bootstrap-packages

popd
