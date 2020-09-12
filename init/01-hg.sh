#
# Python and package managers
#
sudo apt install -y python2.7 python2.7-dev

if ! [ -x "$(command -v pip2.7)" ]; then
    pushd /tmp
    wget https://bootstrap.pypa.io/get-pip.py
    python2.7 get-pip.py --user
    popd
fi

python2.7 -m pip install --user --upgrade pip

#
# Source control
#

python2.7 -m pip install --user --upgrade mercurial
