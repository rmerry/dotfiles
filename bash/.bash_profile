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



########################
#        Paths         #
########################

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/java/jre1.8.0_92/bin:$PATH" # Add JRE to PATH
export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH

export JAVA_HOME=/usr/java/jre1.8.0_92/bin

export PATH="$HOME/.rbenv/bin:$PATH"

# Golang specific configuration
export PATH=$PATH:/usr/local/go/bin
export GOPATH="$HOME/go"
export GOROOT=/usr/local/go
export PATH="$PATH:$GOPATH/bin"

# Load rbenv automatically 
eval "$(rbenv init -)"

########################
#     Load Scripts     #
########################

if [[ -s $HOME/.bash_profile_work ]]; then
    source $HOME/.bash_profile_work
fi

if [[ -s $HOME/.bashrc ]]; then
    source $HOME/.bashrc
fi
