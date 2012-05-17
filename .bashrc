PS1="[\[\033[33m\]\u@\h \w\[\033[0m\]] \d \[\033[32m\]\t\[\033[0m\]\n\$ "

export HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
export HISTSIZE=100000
#export HISTFILE=$HOME/.history/history-$PPID
shopt -s histappend
PROMPT_COMMAND="history -a; history -n"
HISTIGNORE=ls:history #←historyに記録しないコマンド
HISTIGNORE=history:history #←historyに記録しないコマンド
export EDITOR=/usr/bin/vim

