# hg extension packages
pip install --user -U hg-git
pip install --user -U hg-evolve
pip install --user -U keyring
pip install --user -U mercurial_keyring

# hg extensions from source
mkdir -p $DEST/dev/hgext
pushd $DEST/dev/hgext

if [ ! -d "hg-prompt/" ]; then
    hg clone https://code.shawnhoover.dev/hg-prompt
fi

popd
