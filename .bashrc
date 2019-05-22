function color256() { echo -ne "\[\033[38;5;$1m\]"; }
function prompt_fn {
  local exit_code=$?
  local exit_code_str=""
  if [ $exit_code -ne 0 ]; then
    exit_code_str=$(color256 245)"{"$exit_code"}"
  fi
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
  if [ "$HOSTNAME" = "Priyendras-MacBook-Pro.local" ]; then
    PS1="$exit_code_str$(color256 198)[\t \u@\h \${prompt_pwd}]\[\033[0m\]"$'\n'
  else
    PS1="$exit_code_str$(color256 33)[\t \u@\h \${prompt_pwd}]\[\033[0m\]"$'\n'
  fi
}
function mdp() {
  if [[ $# -ge 1 && ! -e "$1" ]]
  then
    touch "$1"
  fi
  open -a /Applications/Markdown\ Plus.app "$@"
}

shopt -s histappend

EDITOR='vim'
PATH="~/bin:$PATH"
HISTSIZE=100000000
HISTFILESIZE=1000000000
HISTCONTROL=ignoredups:erasedups
HISTFILE=~/.bash_history_unlimited
PROMPT_COMMAND="prompt_fn"

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
# The command for colorized ls is different on mac/linux
if [[ $(uname -a) == Darwin* ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color'
fi
alias grep='egrep --color=auto'
alias dmux='tmux attach || tmux new -s default'

# Compass stuff
export GITROOT=$HOME/development
export PATH="/usr/local/bin:${PATH}"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export CREDENTIALS_FILE=~/credentials
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
alias bzl='devdocker/devdocker exec -i bazel'

# Vi editing mode
set -o vi
if [[ $- == *i* ]]; then
  # bind stuff only works in interactive mode.
  bind 'set show-mode-in-prompt on'
  bind 'set vi-cmd-mode-string "\1\e[38;5;245m\2$$ "'
  bind 'set vi-ins-mode-string "\1\e[38;5;10m\2>>\1\e[0m\2 "'
  bind 'set keyseq-timeout 0'  # timeout for esc key
  trap 'echo -ne "\e[0m"' DEBUG
  # Enable auto-completing directory symlinks with a trailing /
  bind 'set mark-symlinked-directories on'
fi
