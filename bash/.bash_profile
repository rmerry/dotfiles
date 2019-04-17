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

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk-11.0.2/bin:/opt/apache-maven-3.6.0/bin"
export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH

# export VIMRUNTIME=/usr/share/vim/vim80

# export PATH="$HOME/.rbenv/bin:$PATH"
JAVA_HOME="/usr/lib/jvm/jdk-11.0.2"
M2_HOME="/opt/apache-maven-3.6.0"

# Golang specific configuration
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export GOPATH="$HOME/go"
# export GOROOT=/usr/local/go

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

# ecobee
alias vpn='sudo openvpn --config ~/.openvpn/config/ecobee.ovpn --auth-retry interact'
export arthur=/home/richard/dev/ecobee/arthur
export theia_go=/home/richard/go/src/github.com/ecobee/theia-go
