The user's dotfiles. The repo was originally set up for Linux and WSL.
MacOS support was added as a standalone folder with very little sharing.

## Directory structure

MacOS:
- `macos/Brewfile`: the list of all brew recipes to install
- `macos/bin`: bin scripts to link in ~/bin/
- `macos/links`: config files to link in ~/
- `macos/tools`: install scripts

Linux:
- (root): *.ln and *.cp files to link and copy, respectively, in ~/
- `bin`: bin scripts to link in ~/bin/
- `init`: install scripts

Shared:
- Makefile
- .github/workflows CI installer checks
