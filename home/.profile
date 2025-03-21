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

# Add the directory of Tizen .NET Command Line Tools to user path.
export PATH=/Users/richardmerry/tizen-studio/tools/ide/bin:$PATH

export DOT_FILES_DIR="${HOME}/code/mine/dotfiles"

#########################################
#      PROGRAMMING LANGUAGES PATHS      #
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
