filetype off

" PLUGINS
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
  Plug 'kien/ctrlp.vim'                     " fuzzy file finder
  Plug 'mileszs/ack.vim'
  Plug 'moll/vim-node'
  Plug 'morhetz/gruvbox'
  " Plug 'natebosch/vim-lsc'                  " vim language server client
  Plug 'pangloss/vim-javascript'
  Plug 'severin-lemaignan/vim-minimap'
  Plug 'shime/vim-livedown', { 'do': 'sudo npm install -g livedown' }
  Plug 'shumphrey/fugitive-gitlab.vim'
  Plug 'thoughtbot/vim-rspec'
  Plug 'tpope/vim-commentary'               " comment out text
  Plug 'tpope/vim-cucumber'
  Plug 'tpope/vim-fugitive'                 " git integration
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-vinegar'                  " enhances netrw
  Plug 'vim-ruby/vim-ruby'
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
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}
  Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
  Plug 'editorconfig/editorconfig-vim'
call plug#end()

" GENERAL CONFIGURATION OPTIONS
set history=1000            " command history size
set bs=2                    " Backspace not working on windows
set colorcolumn=120
set helpheight=100          " full screen help
set hidden                  " don't ask to save when changing buffers (i.e. when jumping to a type definition)
set nocompatible            " force not to run like vi (that's "vee-eye" people!)
set path+=**                " `:find' will work up to 30 sub directories deep
set showcmd                 " show commands as being typed at bottom of screen
set showmatch               " show matching parenthesis
set showmode                " show current mode at bottom of buffer window
set autoread                " automatically reread file if unmodified in vim
set ttyfast
set lazyredraw
set wildignore=*.o,*.obj,*/node_modules/*,*/go/**/vendor/*,tags
set completeopt=longest,menuone

" USER INTERFACE OPTIONS
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_italicize_strings=0
" let g:gruvbox_improved_strings=1

set background=dark
set cursorline                " highlight line currently under cursor
set guioptions-=L             " no left-hand scroll bar in gVim
set guioptions-=T             " no toolbar in gVim
set guioptions-=m             " no menu bar in gVim
set guioptions-=r             " no right-hand scroll bar in gVim
set laststatus=2              " always display statusbar
set mouse=a                   " mouse Support In Terminal
set ttymouse=xterm2
set number                    " line numbers on
set relativenumber            " relative line numbers on
set ruler                     " always show cursor position
set t_8b=[48;2;%lu;%lu;%lum " make true colours work for Vim inside Tmux
set t_8f=[38;2;%lu;%lu;%lum " make true colours work for Vim inside Tmux
" set t_Co=256
set t_ut=                     " use the currect background colour
set termguicolors
set title                     " window title reflects name of current file
set wildmenu                  " show possible tab completion matches in menu above status bar

" SWAP, BACKUP AND UNDO OPTIONS
set directory=$HOME/.vim/swp//
set backupdir=$HOME/.vim/backup//
set undodir=$HOME/.vim/undo//
set undofile
set writebackup

" TEXT RENDERING OPTIONS
set encoding=utf-8
set linebreak           " avoid wrapping lines in middle of words
set scrolloff=3         " number of lines to keep above and below the cursor
set sidescrolloff=5     " number of columns to keep to the left and right of cursor
syntax off

" SEARCH OPTIONS
set hlsearch        " highlight search matches, turn this off temporarily with :noh
set ignorecase      " ignore case when searching
set incsearch       " show search matches as you type
set smartcase       " don't ignore case if search is not all lowercase

" INDENTATION OPTIONS
filetype plugin indent on     " smart auto indentation (instead of older `smartindent`
set autoindent                " new lines inherit indentation of older lines
set expandtab                 " turn tabs into spaces
set nowrap
set shiftwidth=2              " number of spaces for each step of (auto)indent
set softtabstop=2             " number of spaces tab 'counts for' when editing
set tabstop=2                 " show tabs as this many spaces

" FOLD OPTIONS
set foldlevel=1
set foldmethod=indent

set spell spelllang=en_gb
set nospell

" Editor Config Plugin

" * To ensure that this plugin works well with Tim Pope's fugitive
" * If you wanted to avoid loading EditorConfig for any remote files over ssh:
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" underline and highlight spelling mistakes red
autocmd ColorScheme * hi clear SpellBad
    \| hi SpellBad cterm=underline,bold ctermfg=white ctermbg=black

autocmd Filetype set tabstop=2 sts=2 sw=2 et smarttab
autocmd BufNewFile,BufRead *.txt set spell wrap linebreak textwidth=80
autocmd BufRead,BufNewFile text setlocal textwidth=80

" Open Quickfix window automatically after running :make
augroup OpenQuickfixWindowAfterMake
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
augroup END

augroup Go
  autocmd FileType go vmap <Leader>gi :GoImports<Enter>
  " autocmd FileType go autocmd BufWritePre <buffer> :GoImports
augroup END

augroup FiletypeGroup
  au BufNewFile,BufRead *.es6 set filetype=javascript
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

augroup MarkDown
  " Align GitHub-flavored Markdown tables
  autocmd FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
  autocmd Filetype markdown set spell wrap linebreak textwidth=80
augroup END

augroup Terraform
  let g:terraform_align=1
  let g:terraform_fmt_on_save=1
  let g:terraform_fold_sections=1
augroup END

" Omnifuncs
" augroup omnifuncs
"   autocmd!
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   " autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end

" Terminal Settings (see termcap_options) {{{
" }}}

" Custom Keybindings {{{
" For local replace (http://stackoverflow.com/questions/597687/changing-variable-names-in-vim)
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
" QuickFix List Navigation
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
" Location List Navigation
nnoremap [L :lfirst<CR>
nnoremap ]L :llast<CR>
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

" For vimgrep
nnoremap <leader>gw :vimgrep /<C-R><C-W>/gj **<CR>:botright cwindow<CR>
nnoremap <leader>gW :vimgrep /<C-R><C-A>/gj **<CR>:botright cwindow<CR>

map <F4> :execute "vimgrep /" . expand("<cword>") . "/gj **/.* **" <Bar> cw<CR>

" Enhanced editing facilities
nnoremap ds% %x``x          " Remove surrounding {[( objects
nnoremap ds" di"hPl2x       " Remove surrounding double quote

nnoremap <leader><c-p> :CtrlPMRUFiles<CR>

nnoremap <leader>a :Ack! ''<left>

" autocompletion menu
"
" <enter> selects the highlighted menu item
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Run ctags on save
" autocmd BufWritePost * call system("ctags -R")
" }}}

" Plugin Configurations {{{

" CtrlP {{{
"  'c' - the directory of the current file.
"  'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr
"  'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
"  0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:40,results:40'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git/'
let g:ctrlp_show_hidden = 1

" }}}

" Neo Complete {{{
" if exists('g:plugs["neocomplete"]')
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_auto_close_preview=1
" endif

let g:netrw_altfile=1 " Ctrl-^ returns to last edited file and not netrw
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_loc_list_height = 3
let g:syntastic_ruby_checkers = ['rubocop']

let g:fugitive_gitlab_domains = ['https://gitlab.fmts.int']

" ShellCheck {{{
autocmd Filetype sh set makeprg=shellcheck\ -f\ gcc\ % tabstop=4 sts=4 sw=4 et smarttab

augroup programming_language_specific_configuration
  autocmd FileType go call SetGoOptions()
  autocmd FileType javascript call SetJavascriptOptions()
  autocmd FileType ruby call SetRubyOptions()

  function! SetGoOptions()
    nnoremap <F2> :GoRename<CR>
    nnoremap <leader>ge :GoErrCheck<CR>
    nnoremap <leader>gi :GoImport
  endfunction

  function! SetJavascriptOptions()
    "the api folder is a work specific environment configuration
    if filereadable(globpath('.', '.eslintrc*')) || filereadable(globpath('./api/', '.eslintrc*'))
      let g:syntastic_javascript_checkers = ['eslint']
    else
      "autocmd FileType javascript let g:syntastic_javascript_checkers = ['jshint', 'jscs']
      "if !filereadable(".jscsrc")
      "  autocmd FileType javascript let g:syntastic_javascript_jscs_args = "--config ~/dev/git/whitebeam/wb-gulp-tasks/config/.jscsrc"
      "endif
    endif
  endfunction

  function! SetRubyOptions()
    let g:syntastic_javascript_checkers = ['rubocop']

    if filereadable(globpath('.', '.rubocop.yaml'))
      let g:syntastic_ruby_rubocop_args = "--config .rubocop.yaml"
    endif
  endfunction
augroup END

autocmd BufReadPre *.js let b:javascript_lib_use_jasmine = 1
autocmd BufReadPre *.js let b:javascript_lib_use_react = 0
autocmd BufReadPre *.js set suffixesadd+=.js

" let &runtimepath.=',~/.vim/bundle/ale'

command! PrettifyJSON %!python -m json.tool

" Cscope integrations
"
if has("cscope")
  " show msg when any other cscope db added
  set cscopeverbose
  " set csprg=/usr/local/bin/cscope
  " set csto=0
  " set cst
  " set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif

	nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>a :cs find a <C-R>=expand("<cword>")<CR><CR>

	" Using 'CTRL-spacebar' then a search type makes the vim window
	" split horizontally, with search result displayed in
	" the new window.

	nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>a :scs find a <C-R>=expand("<cword>")<CR><CR>

	" Hitting CTRL-space *twice* before the search type does a vertical
	" split instead of a horizontal one

	nmap <C-Space><C-Space>s
		\:vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>g
		\:vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>c
		\:vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>t
		\:vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>e
		\:vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>i
		\:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-Space><C-Space>d
		\:vert scs find d <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>a
		\:vert scs find a <C-R>=expand("<cword>")<CR><CR>

endif

let g:lsc_server_commands = { 'javascript.jsx': 'javascript-typescript-stdio' }
let g:lsc_server_commands = { 'javascript': 'javascript-typescript-stdio' }
" let g:lsc_server_commands = { 'ruby': 'language_server-ruby' }

let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'FindReferences': 'gr',
    \ 'FindCodeActions': 'ga',
    \ 'DocumentSymbol': 'go',
    \ 'ShowHover': 'K',
    \ 'Completion': 'completefunc',
    \}

" STATUS LINE
function! StatuslineGit()
  let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return strlen(l:branchname) > 0 ? printf('[%s]', l:branchname) : ''
endfunction

" Function: display errors from Ale in statusline
function! LinterStatus() abort
  " let l:counts = ale#statusline#Count(bufnr(''))
  " let l:all_errors = l:counts.error + l:counts.style_error
  " let l:all_non_errors = l:counts.total - l:all_errors
  " return l:counts.total == 0 ? '' : printf(
  "       \ 'W:%d E:%d',
  "       \ l:all_non_errors,
  "       \ l:all_errors
  "       \)
endfunction

let &statusline='%<%t%m%r %y%=%{LinterStatus()}%14.{StatuslineGit()}%14.(%l,%c%V %p%)'
highlight ColorColumn ctermbg=white
syntax on
