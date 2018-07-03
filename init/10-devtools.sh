#
# The text editor
#
sudo apt install -y emacs25-nox || sudo apt install -y emacs24-nox

#
# Ruby
#
sudo apt install -y ruby ruby-dev

if ! gem spec ffi > /dev/null 2>&1; then
    sudo gem install ffi
fi

#
# Source control
#
sudo apt install -y git
sudo apt install -y subversion
