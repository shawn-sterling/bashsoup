#!/bin/bash

# colors
export PS1_GREY="\[$(tput bold; tput setaf 0)\]"
export PS1_GREEN="\[$(tput bold; tput setaf 2)\]"
export PS1_YELLOW="\[$(tput bold; tput setaf 3)\]"
export PS1_MAGENTA="\[$(tput bold; tput setaf 5)\]"
export PS1_CYAN="\[$(tput bold; tput setaf 6)\]"
export PS1_WHITE="\[$(tput bold; tput setaf 7)\]"
export PS1_RED="\[$(tput bold; tput setaf 1)\]"
export PS1_RESET="\[$(tput sgr0)\]"

export GIT_PROMPT_DIRTY="±"
export GIT_PROMPT_UNTRACKED="+"
export GIT_PROMPT_CLEAN=""

__git_ps1 ()
{
  local b="$(git symbolic-ref HEAD 2>/dev/null)";
  if [ -n "$b" ]; then
    printf "%s" "${b##refs/heads/}";
  fi
}

__parse_git_status () {
  gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\|modified:\)')

  if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:\|modified:") > 0 ]]; then
        echo -n "$GIT_PROMPT_DIRTY"
  fi

  if [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\)") > 0 ]]; then
        echo -n "$GIT_PROMPT_UNTRACKED"
  fi

  if [[ $(echo ${gitstat} | wc -l | tr -d ' ') == 0 ]]; then
        echo -n "$GIT_PROMPT_CLEAN"
  fi
}

# function to set PS1
function _bash_prompt(){
    # git info
    if [[ $? == 0 ]]; then
        local EXIT_CODE_PROMPT="${PS1_GREY}[${PS1_RESET}$?${PS1_GREY}]"
    else
        local EXIT_CODE_PROMPT="${PS1_GREY}[${PS1_RED}$?${PS1_GREY}]"
    fi
    local GIT_INFO=$(git branch &>/dev/null && echo "${PS1_CYAN}git${PS1_WHITE}: ($(__git_ps1 '%s'))$(__parse_git_status)")
    # add <esc>k<esc>\ to PS1 if screen is running
    # see man(1) screen, section TITLES for more
    if [[ "$TERM" == screen* ]]; then
        local SCREEN_ESC='\[\ek\e\\\]'
    else
        local SCREEN_ESC=''
    fi

    # finally, set PS1
    PS1="\n${PS1_MAGENTA}\u ${PS1_GREY}at${PS1_YELLOW} \h ${PS1_GREY}in${PS1_GREEN} \w ${EXIT_CODE_PROMPT} ${GIT_INFO}\
        \n${SCREEN_ESC}${PS1_WHITE}\\\$${PS1_RESET} "
}

# call _bash_prompt() each time the prompt is refreshed
export PROMPT_COMMAND=_bash_prompt
