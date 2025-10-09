alias k="kubectl"
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF --time-style=full-iso'
alias lss='ls -lahrS'
alias lst='ls -lahrt'
# alias open='xdg-open'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
# alias task='ssh -t -p 65222 bitsociety.duckdns.org task'
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

