#! /bin/bash

function select_screen {
  UNDER_SCREEN=$(ps afxwww | grep $PPID | grep -i screen)
  INTERACTIVE=$(echo $- | grep i)
  if [ ${#UNDER_SCREEN} -eq 0 -a ${#INTERACTIVE} -ne 0 ]; then
    SCREEN_SESSIONS=$(screen -list | /bin/egrep "Attached|Detached")
    if [ ${#SCREEN_SESSIONS} -ne 0 ]; then
      echo -e "\033[1m  List of screen sessions:\033[0m"
      tput sgr0
      echo "$SCREEN_SESSIONS" | sed -e s/'^'/'  '/g
    else
      echo -e "\033[1m  No screens found. Perhaps create a new one?\033[0m"
      tput sgr0
    fi
    echo -e -n "\033[1m  Enter screen session name, or press ENTER to skip screen: \033[0m"
    tput sgr0
    read SELECTED_SESSION
    if [ ${#SELECTED_SESSION} -ne 0 ]; then
      echo -e -n "\033]0;${SELECTED_SESSION}\007"
      EXISTING_SESSION=$(echo "$SCREEN_SESSIONS" | /bin/egrep "[0-9]*\.$SELECTED_SESSION[[:space:]]" | awk --source '{print $1}')
      if [ ${#EXISTING_SESSION} -eq 0 ]; then
        screen -S $SELECTED_SESSION
      else
        screen -r -d -S "$EXISTING_SESSION"
      fi
    fi
  fi
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

shopt -s histappend

export GREP_COLORS='ms=01;32:mc=01;32:sl=:cx=:fn=01;35:ln=32:bn=32:se=36'
export SSH_AUTH_SOCK=''

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ls='ls --color=auto'
#alias awk='awk --file=/home/deshwal/bin/utils.awk'
alias grep="/bin/egrep --color=auto"
alias renderhtml='sed -e s/"<br>"/"\n"/g | sed -e s/"<p>"/"\n"/g | sed -e s/"<\/p>"/"\n"/g | sed -e s/"<\/tr>"/"\n"/g | sed -e s/"<\/th>"/"\t"/g | sed -e s/"<\/td>"/"\t"/g | sed -e s/"<[^>]*>"//g | sed -e /"^[ \t]*$"/d | sed -e s/"\t\t*"/"\t"/g | sed -e s/"&nbsp;"/" "/g'
alias dropblanklines='sed -e /"^[ \t]*$"/d'
alias eatnewlines="perl -e 'while (<>) {chomp(\$_); print \$_;}'"
alias pycalc='python -E'
alias g++='g++ --std=c++0x'

export EDITOR='vim'

export PATH=.:/home/deshwal/bin:$PATH
export LC_ALL=C

export HISTSIZE=100000000
export HISTFILESIZE=1000000000
export HISTCONTROL=erasedups
export HISTFILE=/home/deshwal/.bash_history_unlimited

# Get my custom bash prompt
hostname=$(hostname -s)
username=$(whoami)

function prompt_command {
  #   Find the width of the terminal
  TERMWIDTH=${COLUMNS}

  #   Add all the accessories below ...
  local temp="[xx:xx:xx ${username}@${hostname}:${PWD}]"

  let fillsize=${TERMWIDTH}-${#temp}
  newPWD="${PWD}"

  if [ "$fillsize" -lt "0" ]
  then
    fill=""
    let cut=5-${fillsize}
    newPWD=" ... ${PWD:${cut}}"
  fi
}

PROMPT_COMMAND="history -a && prompt_command"

function setup_prompt {
  local NO_COLOR="\[\033[0m\]"
  local LIGHTRED="\[\033[1;31m\]"
  local LIGHTGREEN="\[\033[1;32m\]"
  local LIGHTYELLOW="\[\033[1;33m\]"
  UNDER_SCREEN=$(ps afxwww | grep $PPID | grep -i screen)
  if [ ${#UNDER_SCREEN} -eq 0 ]; then
    PS1="$LIGHTGREEN[\t $username@\$hostname:\${newPWD}]
$NO_COLOR>> "
  else
    PS1="$LIGHTRED[\t $username@\$hostname:\${newPWD}]
$NO_COLOR>> "
  fi
}

setup_prompt
select_screen

################################################################################
#                          SCALIGENT SPECIFIC STUFF                            #
################################################################################
function scons {
  /usr/bin/scons $@ 2>&1 | tee scons/scons.log
}
export SCALIGENT="/usr/local/scaligent"
export JAVA_HOME=$SCALIGENT/toolchain/jvm/jdk1.7
export MAVEN_HOME=$SCALIGENT/toolchain/apache-maven/apache-maven-3.0.4
export PATH=$MAVEN_HOME:$JAVA_HOME:$PATH
