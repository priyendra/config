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
alias vi="vim"
alias more="less"
alias ll="ls -l"
#alias awk='awk --file=/home/deshwal/bin/utils.awk'
alias emacs="emacs -nw"
alias ngrep="/bin/grep --color=auto"
alias grep="/bin/egrep --color=auto"
alias renderhtml='sed -e s/"<br>"/"\n"/g | sed -e s/"<p>"/"\n"/g | sed -e s/"<\/p>"/"\n"/g | sed -e s/"<\/tr>"/"\n"/g | sed -e s/"<\/th>"/"\t"/g | sed -e s/"<\/td>"/"\t"/g | sed -e s/"<[^>]*>"//g | sed -e /"^[ \t]*$"/d | sed -e s/"\t\t*"/"\t"/g | sed -e s/"&nbsp;"/" "/g'
alias revertall='g4 pending | grep '//' | cut -d \# -f 1 | sed -e s/".*... "//g | xargs g4 revert'
alias dropblanklines='sed -e /"^[ \t]*$"/d'
alias add='mapreduce --mapper=IGNORE_KEY_MAPPER --reducer=SUM_REDUCER'
alias shuffle='sample --num=-1'
alias make-opt='make-opt -j60'
alias make-dbg='make-dbg -j60'
alias eatnewlines="perl -e 'while (<>) {chomp(\$_); print \$_;}'"
alias submit_tests_blaze="blaze --blazerc=/dev/null --objfs build --noresource_autosense --embed_changelist none --nobuild_runfile_links --compilation_mode=fastbuild --forge --copt='-DMUSTANG_USE_64BIT_TOKENPOS'"
alias runtests='grunt -z -r --nofallback --blaze_flags=--forge,--experimental_ld'
alias pycalc='python -E'
alias vless='/usr/share/vim/vim71/macros/less.sh'
alias cleanvim='for extn in swn swo swp swm; do find ./ -name "*.$extn" | xargs rm -f; done'
# alias vimkonsole='konsole --noscrollbar --noresize --nomenubar --notabbar --noframe --vt_sz 323x126 -T editor 2>/dev/null &'
alias link_cmdlog='ln -s $(readlink ./blaze-bin | sed -e s/google3.*//g)command.log .'
alias cpprof='cpprof --pprof_classic'

export EDITOR='vim'

export G4MULTIDIFF=1
export P4CONFIG=.p4config
export P4DIFF="/home/deshwal/bin/vimdiff.py"
export P4MERGE=/home/build/public/eng/perforce/mergep4.tcl
export P4EDITOR="vim"
export PATH=.:/usr/local/google/home/deshwal/bin:/home/deshwal/bin:/usr/java/j2sdk1.4.2_06/bin:/usr/local/symlinks:$PATH
export LC_ALL=C

export GFS_CLIENT_SECURITY_LEVEL="integrity"

export JAVA_HOME=/usr/java/j2sdk1.4.2_06
export CLASSPATH=.:/usr/java/j2sdk1.4.2_06

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

function scons {
  /usr/bin/scons $@ 2>&1 | tee scons.log
}
