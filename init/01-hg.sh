#
# Python and package managers
#
sudo apt install -y python2.7 python2.7-dev

if ! [ -x "$(command -v easy_install)" ]; then
    pushd /tmp
    wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
    popd
fi

if [ -x "$(command -v pip)" ]; then
    pip install --user --upgrade pip
else
    pushd /tmp
    wget https://bootstrap.pypa.io/get-pip.py
    python get-pip.py --user
    popd
fi

#
# Source control
#

# Some extensions break with hg 4.7
# *** failed to import extension hggit: 'module' object has no attribute 'ignore'
easy_install --user "mercurial==4.6.*"
