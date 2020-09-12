#
# The text editor. Full package for desktop, -nox for servers.
#
if ! [ -x "$(command -v emacs)" ]; then
    sudo apt install -y gnutls-dev

    pushd /tmp

    emacs=emacs-27.1
    wget http://ftpmirror.gnu.org/emacs/$emacs.tar.xz
    tar xf $emacs.tar.xz

    cd $emacs
    ./configure --with-gnutls=ifavailable
    make
    sudo make install

    rm -f $emacs.tar.xz
    rm -rf $emacs

    popd
fi


#
# Ruby
#
sudo apt install -y ruby ruby-dev

# Don't spend time installing gem CLI docs
grep no-document ~/.gemrc > /dev/null 2>&1 || echo "gem: --no-document" >> ~/.gemrc

if ! gem spec ffi > /dev/null 2>&1; then
    sudo gem install ffi
fi

#
# Source control
#
sudo apt install -y git
sudo apt install -y subversion
