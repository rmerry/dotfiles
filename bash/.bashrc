# Exit if shell is not running interactively$()
case $- in
    *i*) ;;
    *) return;;
esac


########################
#   Global Variables   #
########################

COLOUR_BLUE="\e[0;34m"
COLOUR_GREEN="\e[0;32m"
COLOUR_LIGHT_GRAY="\e[0;37m"
COLOUR_LIGHT_GREEN="\e[1;32m"
COLOUR_LIGHT_RED="\e[1;31m"
COLOUR_NONE="\e[0m"
COLOUR_RED="\e[0;31m"
COLOUR_WHITE="\e[1;37m"
COLOUR_YELLOW="\e[0;33m"

export TERM="xterm-256color"
[[ $TMUX = "" ]] && export TERM="xterm-256color"

########################
# Function Definitions #
########################

ag() {
    $(which ag) --ignore tags "$@";
}

exitCode() {
    local exit_code="$?"

    if [ "$exit_code" -ne "0" ]; then
        echo -e "${COLOUR_RED}\e[3m${exit_code}!\e[0m "
    fi
}

# Get the git branch name
gitBranchName() {
    local status=$(git status 2> /dev/null)
    local branch_name_line="$(echo $status | head -n 1)"
    local branch_name="$(echo $branch_name_line | cut -d ' ' -f 3)"
    if [[ "$branch_name_line" =~ (^HEAD detached at) ]]; then
      echo -en " ${COLOUR_RED}[HEAD DETACHED]"
    elif [[ "$branch_name_line" =~ (^rebase in progress) ]]; then
      echo -en " ${COLOUR_RED}[REBASE IN PROGRESS]"
    elif [ -n $branch_name ]; then
        # Set color based on clean/staged/dirty.
        if [[ "${status}" =~ (tree clean) ]]; then
            echo -en " ${branch_name}${COLOUR_GREEN} ◼"
          elif [[ "${status}" =~ (Changes (to be committed|not staged)) ]]; then
            echo -en " ${branch_name}${COLOUR_RED} ◼"
        elif [[ "${status}" =~ (Untracked files) ]]; then
            echo -en " ${branch_name}${COLOUR_YELLOW} ◼"
        fi
    fi
}

gag() {
  if [ "$#" -lt "1" ]; then
    echo "Usage: gag [OPTIONS] REGEX"
    return -1
    elif [ "$#" -eq "1" ]; then
      git grep "$1" $(git rev-list --all)
    elif [ "$#" -gt "1" ]; then
      echo not implemented yet
    # implement this
  fi
}

########################
#     Core Config      #
########################

export EDITOR=vim
export HISTCONTROL=ignorespace:ignoredups:erasedups # Avoid duplicates
export HISTFILESIZE=$HISTSIZE
export HISTSIZE=1000000
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
shopt -s cdable_vars  # `cd` will search for exported variables if path not found
shopt -s cdspell      # Make minor corrections to misspellings of directories when using `cd`
shopt -s checkwinsize # Check the win size after each command and update the values of LINES and COLUMNS
shopt -s cmdhist      # Store multiline commands as a single history file entry
shopt -s dirspell     # Make minor corrections to misspellings of directories
shopt -s extglob      # Globbing Options (extended globs [extglob])
shopt -s histappend   # Append to the history file, don't overwrite it
shopt -s globstar     # The '**' glob matches all files and zero or more [sub]directories

# Prevent ctrl+s/ctrl+q behaviour
stty -ixon

# Make less more friendly for non-text input files, see lesspipe(1)
if hash 1lesspipe 2>&-; then
  eval "$(lesspipe)"
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
rxvt*|xterm*|*-256color)
    PS1="\n\[$COLOUR_GREEN\]\w\[$COLOUR_WHITE\]\$(gitBranchName) \[\e[0m\] \n\[\e[90m\]» \[\e[39m\]"
    ;;
*)
    PS1="\w\[$txtcyn\]\$(gitBranchName) \$ "
    ;;
esac

########################
#       Aliases        #
########################

alias irssi='TERM=screen-256color irssi' # this fixes the issue where irssi only refreshes half of screen when scrolling in tmux
alias k="kubectl"
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF --time-style=full-iso'
alias lss='ls -lahrS'
alias lst='ls -lahrt'
alias open='xdg-open'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias task='ssh -t -p 65222 bitsociety.duckdns.org task'
alias tmux='tmux -2' # Start in 256 colour mode
alias vi='vim'
alias rg="rg --ignore-case --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'"
alias cdvc="cd /home/richard/.config/nvim/"

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='grep -E --color=auto'
fi

# git aliases
alias lg='git log --color --graph --pretty=format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset --abbrev-commit'
alias rpull='git pull --rebase'

# Development
alias egrep='grep -E'
alias ngrep='grep -Ern --exclude-dir=node_modules --exclude-dir=logs --exclude=\vendor.*.js --exclude=\prettify.js --exclude=\*.csv --exclude=\*.xml --exclude=\*.html --exclude=\*.js.map --exclude=\bundle.js --exclude=\*.out --exclude=\tags --exclude=\app.*.js'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

bind '"\C-g":"git commit -m \"\"\e[D"'


if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
  . /usr/share/doc/fzf/examples/key-bindings.bash
fi
if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
  . /usr/share/doc/fzf/examples/completion.bash
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/richard/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/richard/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/richard/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/richard/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# Bash Completions
if command -v kubectl 1>/dev/null 2>&1; then
  source <(kubectl completion bash)
fi

test -f ~/.bash_work && source ~/.bash_work


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# rbenv
if command -v rbenv 1>/dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

export CODE_DIR="~/Code"
export NPM_BIN_DIR="/usr/local/lib/nodejs/bin"
export DOTFILES="$CODE_DIR/personal/dotfiles"

export PATH="$NPM_BIN_DIR:$PATH"
alias helm='helm tiller run -- helm'
alias terraform='/home/richard/scripts/terraform'

# Personal scripts
export PATH=$PATH:$HOME/scripts

# Go
export GOPATH=~/go/
export PATH=$PATH:/usr/local/go/bin:~/go/bin
# export PATH=$PATH:$HOME/go/bin
export PATH=$HOME/.cargo/bin:$PATH # Rust package manager

# eval "$(direnv hook bash)"

alias worktask="vim ~/work.todo"
alias personaltask="vim ~/personal.todo"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

########################
#         Rust         #
########################

export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library/
. "$HOME/.cargo/env"



#######################
#         Vim         #
#######################
if ! command -v nvim &> /dev/null
then
  alias vi=vim
else
  alias vi=nvim
  alias vim=nvim
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias luamake=/home/richard/Code/public/lua-language-server/3rd/luamake/luamake
