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
  PS1="$exit_code_str$(color256 198)[\t \u@\h \${prompt_pwd}]\[\033[0m\]"$'\n'
}

shopt -s histappend

EDITOR='vim'
PATH="~/bin:/usr/local/bin:$PATH:."
HISTSIZE=100000000
HISTFILESIZE=1000000000
HISTCONTROL=ignoredups:erasedups
HISTFILE=~/.bash_history_unlimited
PROMPT_COMMAND="prompt_fn"

alias vim='nvim'
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

# devdocker shortcuts
alias dx='devdocker exec'
alias dxi='devdocker exec -i'
alias dsh='devdocker shell'
alias dport='devdocker portfwd'

# Vi editing mode
if [[ $- == *i* ]]; then
  trap 'echo -ne "\e[0m"' DEBUG
fi

# Fuzzy file completion mode.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--extended --layout=reverse --border"

# Rewind up to git root directory.
function gitcd() {
  DIRECTORY=$(realpath .)
  while [ ! -d $DIRECTORY/.git ]; do
    cd ..
    DIRECTORY=$(dirname $DIRECTORY)
  done
}

tabs -2
