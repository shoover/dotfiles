sudo easy_install dulwich # for hg-git

mkdir -p $DEST/dev/hgext
pushd $DEST/dev/hgext

if [ ! -d "hg-git/" ]; then
    hg clone ssh://hg@bitbucket.org/durin42/hg-git
fi

if [ ! -d "hg-prompt/" ]; then
    hg clone ssh://hg@bitbucket.org/sjl/hg-prompt
fi

if [ ! -d "hg-remotebranches/" ]; then
    hg clone ssh://hg@bitbucket.org/durin42/hg-remotebranches
fi

popd

sudo python -m pip install hg-evolve
