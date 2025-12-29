# .zshrc linked from dotfiles. Add local overrides to ~/.zshrc.local.

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='emacsclient'
fi

alias m="make"
alias j="just"
alias jt="just test"

eval "$(direnv hook zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Local overrides
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
