# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# add cargo to path
PATH="$PATH:$HOME/.cargo/bin/"
export PATH

EDITOR="nvim"
export EDITOR

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# aliases
alias bcsoundcore="bluetoothctl connect AC:12:2F:92:58:E3"
alias clk="clock-rs"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias plana="mpvpaper '*' /home/leaves/Videos/backgrounds/plana.mp4 -f -o 'no-audio loop'"

weather() {
	curl "wttr.in/$@?m"
}

cht() {
	curl "cheat.sh/$@"
}

# set cargo env???
# . "$HOME/.cargo/env"

# kitty doesn't work nice with ssh
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# init starship
eval "$(starship init bash)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# init zoxide
eval "$(zoxide init --cmd cd bash)"
