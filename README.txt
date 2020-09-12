My dotfiles setup for bash, devtools, Mercurial, etc. Installer
scripts assume Debian-based generic Linux and Windows Subsystem for
Linux. Conf files work on Msys2 (or used to work; not tested lately
since WSL does almost everything).

To bootstrap from Bitbucket to a Mercurial checkout in $HOME:

```
bash <(curl -s https://code.shawnhoover.dev/dotfiles/raw-file/tip/init/bootstrap.sh)
```

The script prompts before overwriting any dotfiles.
