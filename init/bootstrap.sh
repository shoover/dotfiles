dst=${1:-$HOME}

echo Bootstrap installing dotfiles to $dst

set -e
set -x

cd /tmp
wget -O dotfiles.tar.gz https://bitbucket.org/shoover/dotfiles/get/default.tar.gz
mkdir dotfiles
tar xzf dotfiles.tar.gz --strip 1 -C dotfiles

bash -c dotfiles/init/00-platform.sh
bash -c dotfiles/init/01-hg.sh

rm -rf /tmp/dotfiles

mkdir -p $dst
cd $dst
hg clone ssh://hg@bitbucket.org/shoover/dotfiles
bash -c dotfiles/init/install.sh $dst
