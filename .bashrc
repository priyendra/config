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
alias allcolors='for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done'
alias m='monitor'
alias git='monitor git'

export EDITOR='vim'

export PATH=.:/home/deshwal/bin:$PATH
#export LC_ALL=C

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
  local ORANGE="\e[38;05;202m"
  local GREEN="\e[38;05;46m"
  local YELLOW="\e[38;05;227m"
  local BLUE="\e[38;05;75m"
  local PINK="\e[38;05;213m"
  local HOST=$(hostname)
  if [ $HOST == "dmon" ]; then
    HOSTCOLOR="$GREEN"
  elif [ $HOST == "dmon-ntx" ]; then
    HOSTCOLOR="$YELLOW"
  else
    HOSTCOLOR="$RED"
  fi
  PS1="$HOSTCOLOR[\t $username@\$hostname \${newPWD}]
$NO_COLOR>> "
}

setup_prompt
select_screen

# Enable git auto completion (disabled for now since it was quite painful).
# source ~/.git-completion.bash

################################################################################
#                          SCALIGENT SPECIFIC STUFF                            #
################################################################################
function scons() {
  monitor /usr/bin/scons $@ 2>&1 | tee scons/scons.log
  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    false
  fi
}
export SCALIGENT=/usr/local/scaligent
export SCALIGENT_TOOLCHAIN=$SCALIGENT/toolchain
export JAVA_HOME=$SCALIGENT/toolchain/jvm/jdk1.7.0_06
export MAVEN_HOME=$SCALIGENT/toolchain/apache-maven/apache-maven-3.0.4
export TOMCAT_INSTALL_DIR=/usr/local/scaligent/toolchain/apache-tomcat/apache-tomcat-7.0.30
export GIT_ROOT=/home/deshwal/work/a.scaligent
export CLASSPATH=$GIT_ROOT/callosum/common/target/callosum-common-1.0-SNAPSHOT.jar:$GIT_ROOT/callosum/metadata/target/callosum-metadata-1.0-SNAPSHOT.jar:$GIT_ROOT/callosum/data/target
export PHANTOM_DIR=/usr/local/scaligent/software/phantomjs/bin
export PATH=$MAVEN_HOME/bin:$JAVA_HOME:$PHANTOM_DIR:$PATH

export LANG="en_US.UTF-8"
export SUPPORTED="$LANG:en_US:en"


