##########################
#     Useful Aliases     #
##########################

alias ..="cd .."
alias ytdl-best="youtube-dl \
    -c \
    -q \
    -R 100 \
    --newline \
    --yes-playlist \
    --audio-quality 0 \
    --add-metadata \
    --embed-subs \
    -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"

alias ytdl-audio="youtube-dl \
    -c \
    -q \
    -x \
    --newline \
    --yes-playlist \
    --audio-quality 0 \
    --audio-format mp3 \
    --add-metadata \
    --embed-subs"
alias lisp="clisp"
alias emacs="emacs -nw"

if [[ -x "$(exa -v)" ]]; then
    alias ls="exa --git"
    alias ll="exa --git -l"
else
    alias ll="ls -l"
fi

alias k="kubectl"

########################
#        Paths         #
########################

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk-11.0.2/bin:/opt/apache-maven-3.6.0/bin"
export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH
export PATH="/snap/bin:$PATH"

# export VIMRUNTIME=/usr/share/vim/vim80
# export PATH="$HOME/.rbenv/bin:$PATH"
JAVA_HOME="/usr/lib/jvm/jdk-11.0.2"
M2_HOME="/opt/apache-maven-3.6.0"

# Golang specific configuration
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# personal bin files
export PATH=$PATH:$HOME/.bin

# Load rbenv automatically
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

########################
#     Load Scripts     #
########################

if [[ -s $HOME/.bashrc ]]; then
    source $HOME/.bashrc
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv init -)"

export PATH="$HOME/.cargo/bin:$PATH"
