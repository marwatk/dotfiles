# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
alias grep='grep --color' 
alias scpresume='rsync --partial --progress -r --rsh="ssh"'
alias vi='vim'
