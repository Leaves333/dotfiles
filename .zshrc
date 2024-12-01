source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# init some command line tools
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# kitty doesn't work nice with ssh
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

alias gcc="/opt/homebrew/bin/gcc-14"
alias g++="/opt/homebrew/bin/g++-14"
