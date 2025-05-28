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

GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
RED="\[\033[0;31m\]"
PURPLE="\[\033[0;35m\]"
BROWN="\[\033[0;33m\]"
LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_CYAN="\[\033[1;36m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
YELLOW="\[\033[1;33m\]"
WHITE="\[\033[1;37m\]"
RESTORE="\[\033[0m\]" #0m restores to the terminal's default colour

# Set prompt color here so we can override per-host
bashPromptHostColor="${WHITE}"

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
	if [[ -n "${NO_GIT_STATUS}" || -e "./.no-git-status" ]]; then
		return
	fi
	BRANCH="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
	if [[ -n "${BRANCH}" ]]; then
		STAT="$(parse_git_dirty)"
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status="$(git status 2>&1)"
	bits=''
	if [[ "${status}" == *"renamed:"* ]]; then
		bits=">${bits}"
	fi
	if [[ "${status}" == *"Your branch is ahead of"* ]]; then
		bits="^${bits}"
	fi
	if [[ "${status}" == *"new file:"* ]]; then
		bits="+${bits}"
	fi
	if [[ "${status}" == *"Untracked files"* ]]; then
		bits="?${bits}"
	fi
	if [[ "${status}" == *"deleted:"* ]]; then
		bits="x${bits}"
	fi
	if [[ "${status}" == *"modified:"* ]]; then
		bits="!${bits}"
	fi
	if [[ "${status}" == *"branch is behind"* ]]; then
    bits="v${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function prompt_command {
  if [[ "${marwatk_last_folder}" != "${PWD}" ]]; then
    marwatk_last_folder="${PWD}"
    # We just changed folders
    if [[ -d .git ]]; then
      # Fetch to see if we're behind
      git fetch "$(git remote | head -1)" &>/dev/null
    fi
  fi
  export PS1="$hostPromptUser$shellTitle \[\e[33m\]\w\[\e[0m\] `parse_git_branch 2>/dev/null` \[\e[90m\]`date +%R:%S`\[\e[0m\]\n$eStyle "
}

# For dbhist.sh
export HISTTIMEFORMAT="%s "
export HISTCONTROL=ignorespace
. ~/bin/dbhist.sh

# Source host specific bashrc if it exists
if [ -f "${HOME}/.bashrc_env" ] ; then
  source "${HOME}/.bashrc_env"
fi

# In Cygwin, want to know if the shell is being "Run as administrator"
# So set the prompt to a red #
hostPromptUser="$bashPromptHostColor\u@\h"
shellTitle="\033]0;\w\007"
eStyle='$'
id -G | grep -qE '\<(544|0)\>' && eStyle='\[\e[0;31m\]#\[\e[0m\]'
PROMPT_COMMAND="prompt_command${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
PROMPT_DIRTRIM=3
