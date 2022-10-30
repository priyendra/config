function color256() { echo -ne "\[\033[38;5;$1m\]"; }
function prompt_fn {
  local exit_code=$?
  local exit_code_str=""
  if [ $exit_code -ne 0 ]; then
    exit_code_str=$(color256 1)"⨂ ["$exit_code"]"
  fi
  history -a
  user=$(whoami)
  gitBranch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "=")
  termwidth=${COLUMNS}
  local temp="${exit_code_str}[xx:xx:xx {${gitBranch}} ${user} ]"
  let maxPwd=${termwidth}-${#temp}
  prompt_pwd="${PWD}"
  if [ "$maxPwd" -lt "${#prompt_pwd}" ]
  then
    let cut=$((5 + ${#prompt_pwd} - ${maxPwd}))
    prompt_pwd=" ... ${PWD:${cut}}"
  fi
  promptColor=2
  if [[ $(uname -a) == Darwin* ]]; then
    promptColor=1
  fi
  PS1="$exit_code_str$(color256 $promptColor)[\t $(color256 4){\${gitBranch}}$(color256 $promptColor) \u \${prompt_pwd}]\[\033[0m\]"$'\n'
}

# .bashrc is sourced in SCP sessions and the SCP protocol can at times
# break because of the code here. The following line ensures that .bashrc
# is not sourced in non-interactive shells (e.g. SCP).
[ -z "$PS1" ] && return

shopt -s histappend

if [[ $(uname -a) == Linux* ]]; then
  TERM='xterm-256color'
fi
EDITOR='vim'
PATH="~/bin:.:$PATH"
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
alias dmux='tmux -u attach || tmux -u new -s default'

# devdocker shortcuts
function devdocker () {
  $(git rev-parse --show-toplevel)/tools/devdocker "$@"
}
alias dx='devdocker exec --'
alias dxi='devdocker exec -i --'
alias dsh='devdocker shell'
alias dport='devdocker portfwd'

# Vi editing mode
if [[ $- == *i* ]]; then
  trap 'echo -ne "\e[0m"' DEBUG
fi

# Fuzzy file completion mode.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--extended --layout=reverse --color=fg:0,bg:15,fg+:0,bg+:7,hl:1,hl+:1,gutter:7,pointer:7'
function _fzf_compgen_path() {
  find -L . -type d \( -name "bazel-*" -o -name ".git" -o -name "*node_modules*" \) -prune -o -print | sed -e s@^./@@g
}
export FZF_DEFAULT_COMMAND="_fzf_compgen_path"
export FZF_CTRL_T_COMMAND="_fzf_compgen_path"


# Rewind up to git root directory.
function gitcd() {
  DIRECTORY=$(realpath .)
  while [ ! -d $DIRECTORY/.git ]; do
    cd ..
    DIRECTORY=$(dirname $DIRECTORY)
  done
}

tabs -2

# _dxcomplete() {
#   local word=${COMP_WORDS[COMP_CWORD]}
#   local IFS=$'\n'
#   local gitRoot=$(git rev-parse --show-toplevel)
#   completions=($(devdocker exec $gitRoot/tools/dxcomplete $word || true))
#   for ((i=0; i < "${#completions[@]}"; i++)) {
#     COMPREPLY[$i]=$(printf '%q' "${completions[$i]}")
#   }
# }
# complete -o nospace -F _dxcomplete dxi dx

# Enable ** in bash
shopt -s globstar

# Simple helper fn to list processes from the current tmux window only
function pstmux() {
  tty=$(tty | cut -d / -f 3)
  ps "$@" | grep --color=never $tty
}

export GIT_COMPLETION_CHECKOUT_NO_GUESS=1
