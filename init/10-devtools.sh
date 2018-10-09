#
# The text editor. Full package for desktop, -nox for servers.
#
emacsSuffix=""
ls /usr/bin/*session | egrep -i "gnome|kde[^v]|mate|cinnamon|lxde|xfce|jwm" || emacsSuffix=-nox
sudo apt install -y emacs25$emacsSuffix || sudo apt install -y emacs24$emacsSuffix

#
# Ruby
#
sudo apt install -y ruby ruby-dev

# Don't waste time install gem CLI docs
grep no-document ~/.gemrc > /dev/null 2>&1 || echo "gem: --no-document" >> ~/.gemrc

if ! gem spec ffi > /dev/null 2>&1; then
    sudo gem install ffi
fi

#
# Source control
#
sudo apt install -y git
sudo apt install -y subversion
