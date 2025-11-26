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
export HISTCONTROL=ignoreboth # Avoid duplicates
export HISTSIZE=100000
export HISTFILESIZE=10000000

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

#######
# SSH #
#######

# Ensure agent is running
ssh-add -l &>/dev/null
if [ "$?" == 2 ]; then
    # Could not open a connection to your authentication agent.

    # Load stored agent connection info.
    test -r ~/.ssh-agent && \
        eval "$(<~/.ssh-agent)" >/dev/null

    ssh-add -l &>/dev/null
    if [ "$?" == 2 ]; then
        # Start agent and store agent connection info.
        (umask 066; ssh-agent > ~/.ssh-agent)
        eval "$(<~/.ssh-agent)" >/dev/null
    fi
fi

# Load identities if none are loaded
ssh-add -l &>/dev/null
if [ "$?" == 1 ]; then
    # The agent has no identities. Add all private keys in ~/.ssh.
    for key in ~/.ssh/id_*; do
        # Skip public keys
        [[ "$key" == *.pub ]] && continue

        # Add key if it's a regular file and readable
        if [[ -f "$key" && -r "$key" ]]; then
            ssh-add -t 3600 "$key" >/dev/null 2>&1
        fi
    done
fi

#########
# PATHS #
#########

if [ -f $HOME/.bash_aliases ]; then
	source "$HOME/.bash_aliases"
fi

if [ -f $HOME/.bash_env ]; then
	source "$HOME/.bash_env"
fi

export PATH=$HOME/local/bin:$PATH

# Add all bin folders under ~/.local/share/<application>/bin to PATH
for bin_dir in ~/.local/share/*/bin; do
    if [ -d "$bin_dir" ]; then
        PATH="$bin_dir:$PATH"
    fi
done

# Add all bin folders under ~/.local/share to PATH
for dir in ~/local/*/; do
	PATH="$dir:$PATH"
done
for dir in ~/local/*/bin; do
	PATH="$dir:$PATH"
done

export DOT_FILES_DIR="${HOME}/code/mine/dotfiles"

# PROGRAMMING LANGUAGES PATHS      

# Go
export GOPATH=$HOME/go/
export GOBIN=$GOPATH/bin
export PATH="$GOPATH/bin:$PATH"

# zig
export PATH=$PATH:/usr/local/zig/

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Misc
export TMPDIR=/tmp

# BASH COMMAND LINE COMPLETIONS #

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

######################
# CORE UTILS CONFIGS #
######################

export LESS="-i" # makes less' seearch feature case insensitive

########################
#   GLOBAL VARIABLES   #
########################


# Don't set the TERM variable when using TMUX: use .tmux.conf instead
if [ "$TMUX" = "" ]; then
	export TERM="xterm-256color"
fi

export IGNORED_DIRS="vendor,.git"

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

	local cwd="$(pwd)"
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

	cd "$cwd"
}

function checkhealth() {
	commands=(
		"curl"
		"direnv"
		"fzf"
		"git"
		"delta" # git pager
		"go"
		"jq"
		"make"
		"node"
		"npm"
		"nvim"
		"pip"
		"python"
		"pyenv"
		"rg"
		"rg"
		"ssh"
		"starship"
		"tmux"
		"wget"
		"zoxide"
		"zig"
		"xclip"

		# mainly for i3
		"brightnessctl"
		"pavucontrol"
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

function smart_eval_no_warn() {
	if [[ -z "$1" ]]; then
		echo "Usage: smart_eval <cmd>"
		return 1
	fi

	local cmd=${1%% *}
	if  command -v $cmd &> /dev/null; then
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


#############
# UTILITIES #
#############

smart_eval "direnv hook bash"
smart_eval "fzf --bash"
smart_eval "lesspipe"
smart_eval "starship init bash"
smart_eval_no_warn "pyenv init -"

# Zoxide
smart_eval "zoxide init bash"
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Must be at the very end so that starship doesn't overwrite it
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
