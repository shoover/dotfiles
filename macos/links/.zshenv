# Configuring path for non-login shells (via .zshenv) is required for Emacs exec-path-from-shell
# to work.

export PATH=~/bin:~/.local/bin:/Applications/Emacs.app/Contents/MacOS/bin:/Users/shawn/Library/Python/3.9/bin:$PATH

# Rust's installer needs to see something like this.
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
