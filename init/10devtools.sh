set -x

sudo apt install build-essential
sudo apt install subversion
sudo apt install emacs25-nox
sudo apt install clang

sudo apt install ruby ruby-dev

if ! gem spec ffi > /dev/null 2>&1; then
    sudo gem install ffi
fi

if ! [ -x "$(command -v python)" ]; then
    sudo apt install python2.7 python2.7-dev
    pushd /tmp
    wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
    popd
fi

if ! [ -x "$(command -v pip)" ]; then
    pushd /tmp
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    popd
fi

sudo easy_install mercurial

sudo apt install git
