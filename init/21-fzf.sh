# Installing from source seems to make the keybindings work better than from apt.
ls -al $DEST/.fzf

if ! [ -d $(readlink -f "$DEST/.fzf") ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $DEST/.fzf
fi

git -C $DEST/.fzf pull
$DEST/.fzf/install --all
