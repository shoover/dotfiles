sudo apt-get install -y zsh
chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

pip3 install Markdown powerline-status

# https://blog.joaograssi.com/windows-subsystem-for-linux-with-oh-my-zsh-conemu/
curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ~/.dircolors
