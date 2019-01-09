function prompt_fn {
  history -a
  hostname=$(hostname -s)
  username=$(whoami)
  termwidth=${COLUMNS}
  local temp="[xx:xx:xx ${username}@${hostname}:${prompt_pwd}]"
  let fillsize=${termwidth}-${#temp}
  prompt_pwd="${PWD}"
  if [ "$fillsize" -lt "0" ]
  then
    fill=""
    let cut=5-${fillsize}
    prompt_pwd=" ... ${PWD:${cut}}"
  fi
}
function color256() { echo -ne "\[\033[38;5;$1m\]"; }
function mdp() {
  if [[ $# -ge 1 && ! -e "$1" ]]
  then
    touch "$1"
  fi
  open -a /Applications/Markdown\ Plus.app "$@"
}

shopt -s histappend

EDITOR='vim'
PATH="/Users/deshwal/bin:$PATH"
HISTSIZE=100000000
HISTFILESIZE=1000000000
HISTCONTROL=ignoredups:erasedups
HISTFILE=/Users/deshwal/.bash_history_unlimited
PROMPT_COMMAND="prompt_fn"
PS1="$(color256 198)[\t \u@\h \${prompt_pwd}]\[\033[0m\]"$'\n'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ls='ls -G'
alias grep='egrep --color=auto'

# Enable auto-completing directory symlinks with a trailing /
bind 'set mark-symlinked-directories on'

alias dmux='tmux attach || tmux new -s default'

# Compass stuff
export GITROOT=$HOME/development
export PATH="/usr/local/bin:${PATH}"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export CREDENTIALS_FILE=/Users/deshwal/credentials
export GITROOT=$HOME/development

# tezdb stuff
function dshell {
  DIRECTORY=$(realpath .)
  while [ $DIRECTORY != "/" ]; do
    if [ -f $DIRECTORY/devdocker/devdocker ]; then
      pushd $DIRECTORY > /dev/null
      python devdocker/devdocker shell
      popd > /dev/null
    fi
    DIRECTORY=$(dirname $DIRECTORY)
  done
}
alias devdocker='devdocker/devdocker'
alias dexec='devdocker/devdocker exec -i'

# Vi editing mode
set -o vi
bind 'set show-mode-in-prompt on'
bind 'set vi-cmd-mode-string "\1\e[38;5;245m\2$$ "'
bind 'set vi-ins-mode-string "\1\e[38;5;198m\2>>\1\e[0m\2 "'
bind 'set keyseq-timeout 0'  # timeout for esc key
trap 'echo -ne "\e[0m"' DEBUG
