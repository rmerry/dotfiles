# Bash [ -x ... ] Cheatsheet: Common Test Operators
# -----------------------------------------------
# File-related tests:
# [ -e FILE ]   -> True if FILE exists (any type: file, directory, etc.).
# [ -f FILE ]   -> True if FILE exists and is a regular file (not a directory).
# [ -d FILE ]   -> True if FILE exists and is a directory.
# [ -r FILE ]   -> True if FILE exists and is readable.
# [ -w FILE ]   -> True if FILE exists and is writable.
# [ -x FILE ]   -> True if FILE exists and is executable.
# [ -s FILE ]   -> True if FILE exists and is not empty.
# [ FILE1 -nt FILE2 ] -> True if FILE1 is newer than FILE2 (based on modification time).
# [ FILE1 -ot FILE2 ] -> True if FILE1 is older than FILE2.
# [ FILE1 -ef FILE2 ] -> True if FILE1 and FILE2 refer to the same file (hard link).

# String-related tests:
# [ -z STRING ]  -> True if STRING is empty.
# [ -n STRING ]  -> True if STRING is not empty.
# [ STRING1 = STRING2 ]  -> True if STRING1 is equal to STRING2.
# [ STRING1 != STRING2 ] -> True if STRING1 is not equal to STRING2.

# Numeric-related tests:
# [ NUM1 -eq NUM2 ] -> True if NUM1 is equal to NUM2.
# [ NUM1 -ne NUM2 ] -> True if NUM1 is not equal to NUM2.
# [ NUM1 -lt NUM2 ] -> True if NUM1 is less than NUM2.
# [ NUM1 -le NUM2 ] -> True if NUM1 is less than or equal to NUM2.
# [ NUM1 -gt NUM2 ] -> True if NUM1 is greater than NUM2.
# [ NUM1 -ge NUM2 ] -> True if NUM1 is greater than or equal to NUM2.

# Logical operators:
# [ ! EXPR ]     -> True if EXPR is false (logical NOT).
# [ EXPR1 -a EXPR2 ] -> True if both EXPR1 and EXPR2 are true (logical AND). **Deprecated**
# [ EXPR1 -o EXPR2 ] -> True if either EXPR1 or EXPR2 is true (logical OR). **Deprecated**
# Use `[[ EXPR1 && EXPR2 ]]` or `[[ EXPR1 || EXPR2 ]]` for modern logical operations.

# Example Usage:
# if [ -x /usr/bin/bash ]; then
#   echo "Bash is executable"
# fi
#

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


########
# PATH #
########

export PATH=$HOME/.local/bin:$PATH

# Add all bin folders under ~/.local/share/<application>/bin to PATH
for bin_dir in ~/.local/share/*/bin; do
    if [ -d "$bin_dir" ]; then
        PATH="$bin_dir:$PATH"
    fi
done

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

export DOT_FILES_DIR="${HOME}/code/mine/dotfiles"

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

function whatsmyip() {
	curl -s https://ipinfo.io | jq
}

function check_dotfile_changes() {
	if [ -z "$DOT_FILES_DIR" ]  ; then
		echo 1
		return
	fi
	if [ ! -d "$DOT_FILES_DIR" ]; then
		return
	fi

	cd "$DOT_FILES_DIR"

    # Fetch latest changes from origin
    git fetch origin

    # Get the number of commits ahead and behind
    read ahead behind < <(git rev-list --left-right --count HEAD...origin/master)

    # Check if we are ahead
    if [[ "$ahead" -gt 0 ]]; then
        echo "🚀 You have unpushed dotfile changes!"
    fi

    # Check if we are behind
    if [[ "$behind" -gt 0 ]]; then
        echo "⚠️ Your dotfiles are outdated, pull the latest!"
    fi

	if [[ -n "$(git diff)" ]]; then
		echo "👷🏼 You have uncommitted dotfile changes."
	fi
}

function checkhealth() {
	commands=(
		"curl"
		"direnv"
		"fzf"
		"git"
		"go"
		"jq"
		"make"
		"node"
		"npm"
		"nvim"
		"pip"
		"python"
		"rg"
		"ssh"
		"starship"
		"tmux"
		"wget"
		"zoxide"
	)

	# Loop through the array and check if each command is executable.
	for cmd in "${commands[@]}"; do
		if command -v "$cmd" >/dev/null 2>&1; then
			echo "✅ $cmd"
		else
			echo "❌ $cmd"
		fi
	done
}

# smart_eval works like eval except it checks that the command exists before
# attempting to eval it; if it does not exist it prints a friendly message.
# #
# example usage: smart_eval "fzf --bash"
function smart_eval() {
	if [[ -z "$1" ]]; then
		echo "Usage: smart_eval <cmd>"
		return 1
	fi

	local cmd=${1%% *}
	if ! command -v $cmd &> /dev/null; then
		echo "smart_eval(): $cmd not found, skipping..."
	else 
		eval "$($1)"
	fi
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

#########################################
#         PROGRAMMING LANGUAGES         #
#########################################

# Go
export GOPATH=$HOME/go/
export GOBIN=$GOPATH/bin
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

#############
# UTILITIES #
#############

smart_eval "direnv hook bash"
smart_eval "zoxide init bash"
smart_eval "fzf --bash"
smart_eval "lesspipe"
smart_eval "starship init bash"

if command -v z &> /dev/null; then
	alias cd="z"
fi

####################
#       MACOS      #
####################
if [[ "$(uname)" == "Darwin" ]]; then
	smart_eval "/opt/homebrew/bin/brew shellenv"
fi

#####################
#       CHECKS      #
#####################
check_dotfile_changes

################################
# LEAVE THIS AS THE LAST LINE! #
################################

# If this is a work machine I might have a .bash_work file that needs sourcing
if [ -f "$HOME/.bash_work" ]; then 
	source "$HOME/.bash_work"
fi
