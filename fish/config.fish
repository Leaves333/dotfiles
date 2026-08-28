if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx fish_greeting ""
set -gx EDITOR nvim
set -gx PATH $PATH ~/.cargo/bin/    # add cargo to path
set -gx PATH $PATH ~/.ghcup/bin/    # add ghc to path

alias bcsoundcore "bluetoothctl connect AC:12:2F:92:58:E3"
alias bcairpods "bluetoothctl connect 54:2A:43:6F:13:96"
alias clk "clock-rs"
alias ls "ls --color"

fzf --fish | source
zoxide init --cmd cd fish | source
starship init fish | source


# write my own custom fzf-history function, since i don't like the default one
function fzf-history-widget -d "Show command history"
  set -l -- command_line (commandline)
  set -l -- current_line (commandline -L)
  set -l -- total_lines (count $command_line)
  set -l -- fzf_query (string escape -- $command_line[$current_line])

  set -lx -- FZF_DEFAULT_OPTS (__fzf_defaults '' \
    '--nth=2..,.. --scheme=history --multi --no-multi-line --no-wrap --wrap-sign="\t\t\t↳ " --preview-wrap-sign="↳ "' \
    '--bind=\'shift-delete:execute-silent(for i in (string split0 -- <{+f}); eval builtin history delete --exact --case-sensitive -- (string escape -n -- $i | string replace -r "^\d*\\\\\\t" ""); end)+reload(eval $FZF_DEFAULT_COMMAND)\'' \
    '--bind="alt-enter:become(string join0 -- (string collect -- {+2..} | fish_indent -i))"' \
    "--bind=ctrl-r:toggle-sort,alt-r:toggle-raw --highlight-line $FZF_CTRL_R_OPTS" \
    '--accept-nth=2.. --delimiter="\t" --tabstop=4 --read0 --print0 --with-shell='(status fish-path)\\ -c)

  # Add dynamic preview options if preview command isn't already set by user
  # if string match -qvr -- '--preview[= ]' "$FZF_DEFAULT_OPTS"
  #   # Convert the highlighted timestamp using the date command if available
  #   set -l -- date_cmd '{1}'
  #   if type -q date
  #     if date -d @0 '+%s' 2>/dev/null | string match -q 0
  #       # GNU date
  #       set -- date_cmd '(date -d @{1} \\"+%F %a %T\\")'
  #     else if date -r 0 '+%s' 2>/dev/null | string match -q 0
  #       # BSD date
  #       set -- date_cmd '(date -r {1} \\"+%F %a %T\\")'
  #     end
  #   end
  #
  #   # Prepend the options to allow user customizations
  #   set -p -- FZF_DEFAULT_OPTS \
  #     '--bind="focus,resize:bg-transform:if test \\"$FZF_COLUMNS\\" -gt 100 -a \\\\( \\"$FZF_SELECT_COUNT\\" -gt 0 -o \\\\( -z \\"$FZF_WRAP\\" -a (string length -- {}) -gt (math $FZF_COLUMNS - 4) \\\\) -o (string collect -- {2..} | fish_indent | count) -gt 1 \\\\); echo show-preview; else echo hide-preview; end"' \
  #     '--preview="string collect -- (test \\"$FZF_SELECT_COUNT\\" -gt 0; and string collect -- {+2..}) \\"\\n# \\"'$date_cmd' {2..} | fish_indent --ansi"' \
  #     '--preview-window="right,50%,wrap-word,follow,info,hidden"'
  # end

  set -lx FZF_DEFAULT_OPTS_FILE

  set -lx -- FZF_DEFAULT_COMMAND 'builtin history -z --show-time="%y-%m-%d %T%t"'

  # Enable syntax highlighting colors on fish v4.3.3 and newer
  if set -l -- v (string match -r -- '^(\d+)\.(\d+)(?:\.(\d+))?' $version)
  and test "$v[2]" -gt 4 -o "$v[2]" -eq 4 -a \
    \( "$v[3]" -gt 3 -o "$v[3]" -eq 3 -a \
    \( -n "$v[4]" -a "$v[4]" -ge 3 \) \)

    set -a -- FZF_DEFAULT_OPTS '--ansi'
    set -a -- FZF_DEFAULT_COMMAND '--color=always'
  end

  # Merge history from other sessions before searching
  test -z "$fish_private_mode"; and builtin history merge

  if set -l result (eval $FZF_DEFAULT_COMMAND \| (__fzfcmd) --query=$fzf_query | string split0)
    if test "$total_lines" -eq 1
      commandline -- $result
    else
      set -l a (math $current_line - 1)
      set -l b (math $current_line + 1)
      commandline -- $command_line[1..$a] $result
      commandline -a -- '' $command_line[$b..-1]
    end
  end

  commandline -f repaint
end


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/leaves/.opam/opam-init/init.fish' && source '/home/leaves/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
