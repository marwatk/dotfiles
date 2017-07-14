# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
alias grep='grep --color' 
alias scpresume='rsync --partial --progress -r --rsh="ssh"'
alias vi='vim'

# Source the users bashrc if it exists
if [ -f "${HOME}/.bashrc_env" ] ; then
  source "${HOME}/.bashrc_env"
fi
