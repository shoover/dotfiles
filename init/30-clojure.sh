sudo apt install openjdk-8-jdk-headless

if ! [ -x "lein" ]; then
    curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    mkdir ~/bin
    mv lein ~/bin/
    chmod u+x ~/bin/lein

    # Support cider-jack-in over tramp remote without tramp-own-path or .profile trouble
    sudo ln -s ${HOME}/bin/lein /usr/local/bin/lein
fi
