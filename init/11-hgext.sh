# hg extension packages
easy_install --user hg-git
pip install --user hg-evolve
pip install --user keyring
pip install --user mercurial_keyring

# hg extensions from source
mkdir -p $DEST/dev/hgext
pushd $DEST/dev/hgext

if [ ! -d "hg-prompt/" ]; then
    hg clone https://bitbucket.org/sjl/hg-prompt
fi

if [ ! -d "hg-remotebranches/" ]; then
    hg clone https://bitbucket.org/durin42/hg-remotebranches
fi

popd
