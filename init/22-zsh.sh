#!/bin/bash

set -e

sudo apt-get install -y zsh
sudo chsh $(whoami) -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
