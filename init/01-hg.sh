#
# Python and package managers
#
sudo apt install -y python2.7 python2.7-dev

if ! [ -x "$(command -v easy_install)" ]; then
    pushd /tmp
    wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
    popd
fi

if ! [ -x "$(command -v pip)" ]; then
    pushd /tmp
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py --user
    popd
fi

python -m pip install --user --upgrade pip setuptools wheel

#
# Source control
#

easy_install --user -U mercurial
