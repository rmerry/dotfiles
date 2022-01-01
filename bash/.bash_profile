setxkbmap -option caps:escape
setxkbmap -option rctrl:caps

if [ -s $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi
. "$HOME/.cargo/env"
