#
# The text editor
#
sudo apt install emacs25-nox

#
# Ruby
#
sudo apt install ruby ruby-dev

if ! gem spec ffi > /dev/null 2>&1; then
    sudo gem install ffi
fi

#
# Source control
#
sudo apt install git
sudo apt install subversion
