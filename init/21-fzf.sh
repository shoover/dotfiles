# Installing from source seems to make the keybindings work better than from apt.
if ! [ -d $(readlink -f "~/.fzf") ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

git -C ~/.fzf pull
~/.fzf/install --all
