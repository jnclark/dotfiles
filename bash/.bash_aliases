#emacs client, -c for new frame
alias ec=ecn
alias ecn='emacsclient -n'
alias ect='emacsclient -t'
alias ecterm='emacsclient -nw'

# less with syntax highlighting
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -FRX '
