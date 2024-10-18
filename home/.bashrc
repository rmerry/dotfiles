# Exit if shell is not interactive
if [ -z "$PS1" ]; then
	return 
fi

########################
#     CORE CONFIG      #
########################

export EDITOR=vi
export HISTCONTROL=ignorespace:ignoredups:erasedups # Avoid duplicates
export HISTFILESIZE=$HISTSIZE
export HISTSIZE=1000000

shopt -s histappend   # When the shell exits, append to the history file instead of overwriting it
#shopt -s cdable_vars # `cd` will search for exported variables if path not found
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
if command -v lesspipe &> /dev/null; then
	eval "$(lesspipe)"
fi

########
# PATH #
########

export PATH=$PATH:$HOME/scripts # Personal scripts
export PATH=$HOME/local/bin:$PATH
export PATH=$PATH:$HOME/bin 

###################################################
# APPLICATION INSTALL LOCATIONS (CUSTOM PREFIXES) #
###################################################

export PATH=$HOME/local/nvim/bin:$PATH
export PATH=$HOME/local/go/bin:$PATH

######################
# CORE UTILS CONFIGS #
######################

export LESS="-i" # makes less' seearch feature case insensitive

########################
#   GLOBAL VARIABLES   #
########################

if command -v tput &> /dev/null; then

	# Colours
	RED=$(tput setaf 1)
	GREEN=$(tput setaf 2)
	YELLOW=$(tput setaf 3)
	WHITE=$(tput setaf 7)

	# Styles
	BOLD=$(tput bold)
	NORMAL=$(tput sgr0)
	DIM=$(tput dim)
	ITALIC=$(tput sitm)

else
	echo "Warning: tput is not installed! Using basic mono-colour prompt."
fi


# Don't set the TERM variable when using TMUX: use .tmux.conf instead
if [ "$TMUX" = "" ]; then
	export TERM="xterm-256color"
fi

export IGNORED_DIRS="vendor,.git"

########################
#       ALIASES        #
########################

alias k="kubectl"
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF --time-style=full-iso'
alias lss='ls -lahrS'
alias lst='ls -lahrt'
# alias open='xdg-open'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias task='ssh -t -p 65222 bitsociety.duckdns.org task'
alias tmux='tmux -2' # Start in 256 colour mode
alias rg="rg --ignore-case --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'"
alias cdvc="cd /home/richard/.config/nvim/"
alias rg="rg --hidden"
alias irssi="irssi --config=<((cat $HOME/.irssi/server_config && cat $HOME/.irssi/config))"

# fzf shortcuts
alias git-switch-branch="git switch \$(git branch | fzf)"
alias git-find-file="git ls-files | fzf"

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r $HOME/dircolors && eval "$(dircolors -b $HOME/dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='grep -E --color=auto'
fi

# git 
alias lg='git log --color --graph --pretty=format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset --abbrev-commit'
alias rpull='git pull --rebase'

# grep
alias egrep='grep -E'
alias ngrep='grep -Ern --exclude-dir=node_modules --exclude-dir=logs --exclude=\vendor.*.js --exclude=\prettify.js --exclude=\*.csv --exclude=\*.xml --exclude=\*.html --exclude=\*.js.map --exclude=\bundle.js --exclude=\*.out --exclude=\tags --exclude=\app.*.js'

# # Vim 
if command -v nvim &> /dev/null; then
	alias vi=nvim
	alias vim=nvim
elif command -v vim &> /dev/null; then
	alias vi=vim
fi

########################
# FUNCTION DEFINITIONS #
########################



###################
# CUSTOM BINDINGS #
###################

bind '"\C-g":"git commit -m \"\"\e[D"'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/richard/Downloads/google-cloud-sdk/path.bash.inc' ]; then 
	source "/home/richard/Downloads/google-cloud-sdk/path.bash.inc"
fi

#################################
# BASH COMMAND LINE COMPLETIONS #
#################################

# Bash (this is probably not necessary as usually sourced in /etc/bash.bashrc or /etc/profile)
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		source /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		source /etc/bash_completion
	elif [ -f /opt/homebrew/etc/profile.d/bash_completion.sh  ]; then
		source /opt/homebrew/etc/profile.d/bash_completion.sh
	fi
fi

#########################################
#         PROGRAMMING LANGUAGES         #
#########################################

# Go
export GOPATH=$HOME/go/
export PATH="$GOPATH/bin:$PATH"

# zig
export PATH=$PATH:/usr/local/zig/

# NodeJS
export NPM_BIN_DIR="/usr/local/lib/nodejs/bin"

export PATH="$NPM_BIN_DIR:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null; then
	eval "$(pyenv init -)"
fi

# Ruby
if command -v rbenv &>/dev/null; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# Rust
if command -v rustc &> /dev/null; then
	export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library/
	export PATH="$HOME/.cargo/bin:$PATH" # Rust package manager
fi
if [ -f "$HOME/.cargo/env" ]; then
	source "$HOME/.cargo/env"
fi

#############
# UTILITIES #
#############

# direnv
if command -v direnv &> /dev/null; then
	eval "$(direnv hook bash)"
fi

if command  -v /opt/homebrew/bin/brew &> /dev/null; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

################################
# LEAVE THIS AS THE LAST LINE! #
################################

# If this is a work machine I might have a .bash_work file that needs sourcing
if [ -f "$HOME/.bash_work" ]; then 
	source "$HOME/.bash_work"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if command -v cargo &> /dev/null; then
	source "$HOME/.cargo/env"
fi

if command -v zoxide &> /dev/null; then
	eval "$(zoxide init bash)"
	alias cd="z"
fi

############
# STARSHIP #
############

eval "$(starship init bash)"
