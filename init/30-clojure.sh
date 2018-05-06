sudo apt install openjdk-8-jdk-headless

if ! [ -x "$(command -v lein)" ]; then
    curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    mkdir -p $DEST/bin
    mv lein $DEST/bin/
    chmod u+x $DEST/bin/lein

    # Support cider-jack-in over tramp remote without tramp-own-path or .profile trouble
    sudo ln -s ${HOME}/bin/lein /usr/local/bin/lein
fi
