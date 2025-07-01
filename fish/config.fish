if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx fish_greeting ""
set -gx EDITOR nvim
set -gx PATH $PATH ~/.cargo/bin/

alias bcsoundcore "bluetoothctl connect AC:12:2F:92:58:E3"
alias clk "clock-rs"
alias ls "ls --color"

fzf --fish | source
zoxide init --cmd cd fish | source
starship init fish | source
