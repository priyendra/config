function color256() { echo -ne "\[\033[38;5;$1m\]"; }
function prompt_fn {
  local exit_code=$?
  local exit_code_str=""
  if [ $exit_code -ne 0 ]; then
    exit_code_str=$(color256 245)"{"$exit_code"}"
  fi
  history -a
  host=$(hostname -s)
  user=$(whoami)
  gitBranch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "=")
  termwidth=${COLUMNS}
  local temp="${exit_code_str}[xx:xx:xx ${gitBranch} ${user}@${host}:${prompt_pwd}]"
  let fillsize=${termwidth}-${#temp}
  prompt_pwd="${PWD}"
  if [ "$fillsize" -lt "0" ]
  then
    fill=""
    let cut=5-${fillsize}
    prompt_pwd=" ... ${PWD:${cut}}"
  fi
  promptColor=34
  if [[ $(uname -a) == Darwin* ]]; then
    promptColor=198
  fi
  PS1="$exit_code_str$(color256 $promptColor)[\t $(color256 4){\${gitBranch}}$(color256 $promptColor) \u@\h \${prompt_pwd}]\[\033[0m\]"$'\n'
}

# .bashrc is sourced in SCP sessions and the SCP protocol can at times
# break because of the code here. The following line ensures that .bashrc
# is not sourced in non-interactive shells (e.g. SCP).
[ -z "$PS1" ] && return

shopt -s histappend

TERM='xterm'
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
alias devdocker='tools/devdocker'
alias dx='devdocker exec --'
alias dxi='devdocker exec -i --'
alias dsh='devdocker shell'
alias dport='devdocker portfwd'
alias bazel='tools/safebazel'

# Vi editing mode
if [[ $- == *i* ]]; then
  trap 'echo -ne "\e[0m"' DEBUG
fi

# Fuzzy file completion mode.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--extended --layout=reverse"

# Rewind up to git root directory.
function gitcd() {
  DIRECTORY=$(realpath .)
  while [ ! -d $DIRECTORY/.git ]; do
    cd ..
    DIRECTORY=$(dirname $DIRECTORY)
  done
}

tabs -2
