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
export PROMPT_COMMAND=__prompt_command

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
if hash lesspipe 2>&-; then
	eval "$(lesspipe)"
fi

########################
#   GLOBAL VARIABLES   #
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

# Don't set the TERM variable when using TMUX: use .tmux.conf instead
if [ "$TMUX" = "" ]; then
	export TERM="xterm-256color"
fi

########################
#       ALIASES        #
########################

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
alias rg="rg --ignore-case --colors 'match:bg:yellow' --colors 'match:fg:black' --colors 'match:style:nobold' --colors 'path:fg:green' --colors 'path:style:bold' --colors 'line:fg:yellow' --colors 'line:style:bold'"
alias cdvc="cd /home/richard/.config/nvim/"
alias rg="rg --hidden"
alias irssi="irssi --config=<((cat $HOME/.irssi/server_config && cat $HOME/.irssi/config))"

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

# Vim 
if command -v nvim &> /dev/null; then
	alias vi=nvim
	alias vim=nvim
elif command -v vim &> /dev/null; then
	alias vi=vim
fi

########################
# FUNCTION DEFINITIONS #
########################

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

##########
# PROMPT #
##########

__prompt_command() {
	local exit_code="$?"

	local italic='\[\e[3m'
	local code_clear='\[\e[0m\]'
	local dim='\[\e[2m'
	local dim_end='\[\e[22m'

	local file_count="$(ls -al | wc -l)"
	local file_string="empty"
	if [ $file_count -gt 0 ]; then
		file_string="${file_count} files"
	fi

	# git repo info
	PS1="\[$COLOUR_WHITE\]\$(gitBranchName) ${code_clear} \[$COLOUR_GREEN\]\w ${dim}(${file_string})${dim_end} \n\[\e[90m\]» \[\e[39m\]"

	# background job info
	local job_count="$(jobs -l | wc -l)"
	local jobs_label="job"
	if [ $job_count -gt 0 ]; then
		if [ $job_count -gt 1 ]; then
			jobs_label="jobs"
		fi
		PS1="${dim}[${job_count}-${jobs_label}]${dim_end} ${PS1}"
	fi

	# exit code info
	if [ "$exit_code" != 0 -a "$exit_code" != 148 ]; then # 148 being the code after doing a ^-z
		PS1="${COLOUR_LIGHT_RED}${exit_code}🠕${code_clear} ${PS1}"
	fi

	PS1="\n${PS1} "

	history -a
	history -c
	history -r
}

###################
# CUSTOM BINDINGS #
###################

bind '"\C-g":"git commit -m \"\"\e[D"'

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi

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
	fi
fi

# FZF
if [ -f "$HOME/fzf.bash" ]; then
	source "$HOME/fzf.bash"
fi
if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
	source /usr/share/doc/fzf/examples/completion.bash
fi

# kubectl
if command -v kubectl 1>/dev/null 2>&1; then
	source <(kubectl completion bash)
fi

# google-cloud-sdk
if [ -f '/home/richard/Downloads/google-cloud-sdk/completion.bash.inc' ]; then 
	source '/home/richard/Downloads/google-cloud-sdk/completion.bash.inc'
fi

#########################################
#         PROGRAMMING LANGUAGES         #
#########################################

export CODE_DIR="$HOME/Code"
export DOTFILES="$CODE_DIR/personal/dotfiles"
export PATH=$PATH:$HOME/scripts # Personal scripts

# Go
export GOPATH=$HOME/go/
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# NodeJS
export NPM_BIN_DIR="/usr/local/lib/nodejs/bin"
export PATH="$NPM_BIN_DIR:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin # Where pip installs things
if command -v pyenv &>/dev/null; then
	eval "$(pyenv init -)"
fi

# Ruby
if command -v rbenv &>/dev/null; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

alias helm='helm tiller run -- helm'
alias terraform='/home/richard/scripts/terraform'

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

################################
# LEAVE THIS AS THE LAST LINE! #
################################

# If this is a work machine I might have a .bash_work file that needs sourcing
if [ -f "$HOME/.bash_work" ]; then 
	source "$HOME/.bash_work"
fi
