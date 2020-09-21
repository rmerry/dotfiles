call plug#begin('~/.vim/plugged')
  " For this I use the vim-plug plugin manager (https://github.com/jwhitley/vim-plug)
  "
  " To install run:
  "   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  "       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "
  Plug 'fatih/vim-go'                       " Golang
  Plug 'godlygeek/tabular'                  " text tabularisation
  Plug 'google/vim-searchindex'             " display search pattern index
  Plug 'hashivim/vim-terraform'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'junegunn/vim-easy-align'            " Aligning markdown tables
  " Plug 'kien/ctrlp.vim'                     " fuzzy file finder
  Plug 'mileszs/ack.vim'
  Plug 'moll/vim-node'
  Plug 'morhetz/gruvbox'
  " Plug 'natebosch/vim-lsc'                  " vim language server client
  " Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }
  " Plug 'pangloss/vim-javascript'
  Plug 'severin-lemaignan/vim-minimap'
  Plug 'shime/vim-livedown', { 'do': 'sudo npm install -g livedown' }
  Plug 'shumphrey/fugitive-gitlab.vim'
  " Plug 'thoughtbot/vim-rspec'
  Plug 'tpope/vim-commentary'               " comment out text
  " Plug 'tpope/vim-cucumber'
  Plug 'tpope/vim-fugitive'                 " git integration
  " Plug 'tpope/vim-rails'
  Plug 'tpope/vim-vinegar'                  " enhances netrw
  " Plug 'vim-ruby/vim-ruby'
  " Plug 'w0rp/ale'                           " linter integration
  Plug 'owickstrom/vim-colors-paramount'
  " Plug 'plan9-for-vimspace/acme-colors'
  Plug 'olivertaylor/vacme'
  Plug 'fxn/vim-monochrome'
  Plug 'robertmeta/nofrils'
  Plug 'pbrisbin/vim-colors-off'
  Plug 'pbrisbin/vim-colors-off'
  Plug 'KKPMW/distilled-vim'
  Plug 'JaySandhu/xcode-vim'
  Plug 'rakr/vim-two-firewatch'
  Plug 'romainl/Apprentice'
  Plug 'gergap/wombat256'
  " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
  " Plug 'nvie/vim-flake8'
  Plug 'editorconfig/editorconfig-vim'
  " Plug 'rust-lang/rust.vim'
  Plug 'pechorin/any-jump.vim'
  Plug 'aserebryakov/vim-todo-lists'
  Plug 'fifi2/gtd.vim'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
call plug#end()
