My dotfiles setup for bash and devtools. Installer scripts assume Debian-based
generic Linux and Windows Subsystem for Linux. Conf files work on Msys2 (or used
to work; not tested lately since WSL does almost everything).

To bootstrap from the web to a local checkout in $HOME:

```
bash <(curl -s https://raw.githubusercontent.com/shoover/dotfiles/main/init/bootstrap.sh)
```

The script prompts before overwriting any dotfiles.
