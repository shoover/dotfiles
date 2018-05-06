#
# Python and package managers
#
sudo apt install python2.7 python2.7-dev

if ! [ -x "$(command -v easy_install)" ]; then
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

#
# Source control
#
sudo easy_install mercurial
