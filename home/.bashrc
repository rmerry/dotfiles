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
#shopt -s cdable_vars  # `cd` will search for exported variables if path not found
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
export PATH=$PATH:$HOME/.local/bin 
export PATH=$PATH:$HOME/bin 
export PATH=$PATH:$HOME/local/bin 

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


backupCodeDir() {
	if ! command -v rsync &> /dev/null; then
		echo "ERROR: rsync is not installed!"
		return
	fi

	if [[ -z $NAS_SERVER_URL ]]; then
		echo "ERROR: NAS_SERVER_URL environment variable not set."
	fi

	rsync -av ~/code/mine rsync@$NAS_SERVER_URL::rsync/code/mine
}

exitCode() {
	local exit_code="$?"

	if [ "$exit_code" -ne "0" ]; then
		echo -e "${RED}\e[3m${exit_code}!\e[0m "
	fi
}

# Get the git branch name
gitBranchName() {
	local status=$(git status 2> /dev/null)
	local gitSymbol=""
	local branch_name_line="$(echo $status | head -n 1)"
	local branch_name="$(echo $branch_name_line | cut -d ' ' -f 3)"
	if [[ "$branch_name_line" =~ (^HEAD detached at) ]]; then
		echo -en " ${RED}${gitSymbol} [HEAD DETACHED]"
	elif [[ "$branch_name_line" =~ (^rebase in progress) ]]; then
		echo -en " ${RED}${gitSymbol} [REBASE IN PROGRESS]"
	elif [ -n $branch_name ]; then
		# Set color based on clean/staged/dirty.
		if [[ "${status}" =~ (tree clean) ]]; then
			echo -en "${GREEN}${branch_name} ${gitSymbol}"
		elif [[ "${status}" =~ (Changes (to be committed|not staged)) ]]; then
			echo -en "${RED}${branch_name} ${gitSymbol}"
		elif [[ "${status}" =~ (Untracked files) ]]; then
			echo -en "${YELLOW}${branch_name} ${gitSymbol} "
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

printTimestampAndExitCode() {
	local exit_code="$1"
	local timestamp="$(date '+%H:%M:%S')"
	local exit_code_colour="$GREEN"

	if [ $exit_code -gt 0 ]; then
		exit_code_colour="$RED"
	fi

	let COL=$(tput cols)-${#timestamp}+${#GREEN}+${#NORMAL}

	printf "\n%b%s%${COL}s\n\n" "$DIM" "$timestamp" "$exit_code_colour[$exit_code]$NORMAL"
}

##########
# PROMPT #
##########

__prompt_command() {
	local exit_code="$?"
	local file_count="$(ls -al | wc -l | awk '{$1=$1};1')"
	local file_string="empty"

	if [ $file_count -gt 0 ]; then
		file_string="${file_count} files"
	fi

	printTimestampAndExitCode $exit_code

	# git repo info
	PS1="\$(gitBranchName) \[$WHITE\]\w ${DIM}(${file_string})${NORMAL} \n\[\e[90m\]» \[\e[39m\]"

	# background job info
	local job_count="$(jobs -l | wc -l | awk '{$1=$1};1')"
	local jobs_label="job"
	if [ $job_count -gt 0 ]; then
		if [ $job_count -gt 1 ]; then
			jobs_label="jobs"
		fi
		PS1="${DIM}[${job_count}-${jobs_label}]${NORMAL} ${PS1}"
	fi

	history -a
	history -c
	history -r
}

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

###############
# FZF OPTIONS #
###############

if [ -f "$HOME/fzf.bash" ]; then
	source "$HOME/fzf.bash"
fi
if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
	source /usr/share/doc/fzf/examples/completion.bash
fi
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi

export FZF_DEFAULT_OPTS='--height 25% --layout=reverse --border=none'

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

# Go
export GOPATH=$HOME/go/
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPRIVATE="github.com/limejump/,github.com/rmerry/";

# zig
export PATH=$PATH:/usr/local/zig/

# NodeJS
export NPM_BIN_DIR="/usr/local/lib/nodejs/bin"
export PATH="$NPM_BIN_DIR:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

eval "$(/opt/homebrew/bin/brew shellenv)"

################################
# LEAVE THIS AS THE LAST LINE! #
################################

# If this is a work machine I might have a .bash_work file that needs sourcing
if [ -f "$HOME/.bash_work" ]; then 
	source "$HOME/.bash_work"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"

eval "$(zoxide init bash)"
