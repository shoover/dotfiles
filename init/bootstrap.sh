dst=${1:-$HOME}

cd /tmp
wget -O dotfiles.tar.gz https://bitbucket.org/shoover/dotfiles/get/default.tar.gz
tar xzf dotfiles.tar.gz

bash -c dotfiles/init/00-platform.sh
bash -c dotfiles/init/01-hg.sh

mkdir -p $dst
cd $dst
hg clone ssh://hg@bitbucket.org/shoover/dotfiles
bash -c $dst/dotfiles/init/install.sh
