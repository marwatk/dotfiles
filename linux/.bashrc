# If not running interactively, don't go further
[[ "$-" != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Shell Options
alias grep='grep --color' 
alias scpresume='rsync --partial --progress -r --rsh="ssh"'
alias vi='vim'
export TERM=xterm-256color
alias myhist='cat ~/.bash_eternal_history.alt'

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

#Prevent Ctrl+s from locking terminal
#https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# Set prompt color here so we can override per-host
bashPromptHostColor="\[\e[37m\]"
#Default
  #bashPromptHostColor="\[\e[39m\]"
#Black
  #bashPromptHostColor="\[\e[30m\]"
#Red
  #bashPromptHostColor="\[\e[31m\]"
#Green
  #bashPromptHostColor="\[\e[32m\]"
#Yellow
  #bashPromptHostColor="\[\e[33m\]"
#Blue
  #bashPromptHostColor="\[\e[34m\]"
#Magenta
  #bashPromptHostColor="\[\e[35m\]"
#Cyan
  #bashPromptHostColor="\[\e[36m\]"
#Light gray
  #bashPromptHostColor="\[\e[37m\]"
#Dark gray
  #bashPromptHostColor="\[\e[90m\]"
#Light red
  #bashPromptHostColor="\[\e[91m\]"
#Light green
  #bashPromptHostColor="\[\e[92m\]"
#Light yellow
  #bashPromptHostColor="\[\e[93m\]"
#Light blue
  #bashPromptHostColor="\[\e[94m\]"
#Light magenta
  #bashPromptHostColor="\[\e[95m\]"
#Light cyan
  #bashPromptHostColor="\[\e[96m\]"
#White
  #bashPromptHostColor="\[\e[97m\]"

if hash git 2>/dev/null; then
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global color.ui true

	git config --global color.diff-highlight.oldNormal    "red bold"
	git config --global color.diff-highlight.oldHighlight "red bold 52"
	git config --global color.diff-highlight.newNormal    "green bold"
	git config --global color.diff-highlight.newHighlight "green bold 22"

	git config --global color.diff.meta       "yellow"
	git config --global color.diff.frag       "magenta bold"
	git config --global color.diff.commit     "yellow bold"
	git config --global color.diff.old        "red bold"
	git config --global color.diff.new        "green bold"
	git config --global color.diff.whitespace "red reverse"
fi


# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# In Cygwin, want to know if the shell is being "Run as administrator"
# So set the prompt to a red #
hostPromptUser="$bashPromptHostColor\u@\h"
shellTitle="\033]0;\w\007"
eStyle='$'
id -G | grep -qE '\<(544|0)\>' && eStyle='\[\e[0;31m\]#\[\e[0m\]'
PS1="$hostPromptUser$shellTitle \[\e[33m\]\w\[\e[0m\] \`parse_git_branch\` \n$eStyle "
PROMPT_DIRTRIM=3



# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
# Also write to a backup file in case the real one is clobbered
# https://debian-administration.org/article/543/Bash_eternal_history
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'history -a; echo "$(history 1)" >> ~/.bash_eternal_history.alt'
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTCONTROL=ignoreboth

# Source host specific bashrc if it exists
if [ -f "${HOME}/.bashrc_env" ] ; then
  source "${HOME}/.bashrc_env"
fi

