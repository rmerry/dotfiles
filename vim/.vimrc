filetype off

set bs=2            " Backspace not working on windows
set colorcolumn=120
set helpheight=100  " full screen help
set hidden          " don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hlsearch        " highlight search matches, turn this off temporarily with :noh
set ignorecase      " ignore case when searching
set incsearch       " show search matches as you type
set laststatus=2    " always display statusbar
set mouse=a         " mouse Support In Terminal
set nocompatible    " force not to run like vi (that's "vee-eye" people!)
set noswapfile
set nowrap
set number          " line numbers on
set path+=**        " `:find' will work up to 30 sub directories deep
set relativenumber
set showcmd
set showmatch       " show matching parenthesis
set smartcase       " don't ignore case if search is not all lowercase
set ttyfast
set wildignore=*.o,*.obj,*/node_modules/*,*/go/**/vendor/*,tags
set wildmenu        " show possible tab completion matches in menu above status bar
set completeopt=longest,menuone

" tab settings
set autoindent
set expandtab         " turn tabs into spaces
set shiftwidth=2      " number of spaces for each step of (auto)indent
set smartindent
set softtabstop=2     " number of spaces tab 'counts for' when editing
set tabstop=2         " number of spaces tab 'counts for' in the file

" folds settings
set foldlevel=1
set foldmethod=indent

" colour settings
set background=dark
" set t_Co=256
set termguicolors
set t_ut=   " use the currect background colour

" make true colours work for Vim inside Tmux
set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

" gVim chrome settings
set guioptions-=m " menu bar
set guioptions-=T " toolbar
set guioptions-=r " right-hand scroll bar
set guioptions-=L " left-hand scroll bar

" Plugin Installations
" For this I use the vim-plug plugin manager (https://github.com/jwhitley/vim-plug)
" To install run:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
call plug#begin('~/.vim/plugged')
  " Colour schemes
  Plug 'morhetz/gruvbox'
  " Cucumber
  Plug 'tpope/vim-cucumber'
  " Golang
  Plug 'fatih/vim-go'
  " Javascript
  Plug 'jelera/vim-javascript-syntax'
  Plug 'moll/vim-node'
  Plug 'pangloss/vim-javascript'
  " Markdown
  Plug 'shime/vim-livedown', { 'do': 'sudo npm install -g livedown' }
  " Ruby
  Plug 'tpope/vim-rails'
  Plug 'vim-ruby/vim-ruby'
  Plug 'thoughtbot/vim-rspec'
  " Utilities
  Plug 'godlygeek/tabular' " text tabularisation
  Plug 'google/vim-searchindex' " display search pattern index
  Plug 'kien/ctrlp.vim' " fuzzy file finder
  Plug 'natebosch/vim-lsc' " vim language server client
  Plug 'tpope/vim-commentary' " comment out text
  Plug 'tpope/vim-fugitive' " git integration
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-vinegar' " enhances netrw
  Plug 'w0rp/ale' " linter integration
call plug#end()

let g:gruvbox_italic=1
colorscheme gruvbox

autocmd Filetype set tabstop=2 sts=2 sw=2 et smarttab
autocmd Filetype markdown set spell wrap linebreak textwidth=80
autocmd Filetype text set spell wrap linebreak textwidth=80
autocmd BufRead,BufNewFile text setlocal textwidth=80
autocmd Filetype javascript,ruby set tabstop=2 sts=2 sw=2 et smarttab 

" Remove trailing whitespace
autocmd FileType c,cpp,go,java,javascript,json,php,python,ruby autocmd BufWritePre <buffer> %s/\s\+$//e 

augroup FiletypeGroup
  au BufNewFile,BufRead *.es6 set filetype=javascript
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" Omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

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
map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>
" Enhanced editing facilities
nnoremap ds% %x``x          " Remove surrounding {[( objects
nnoremap ds" di"hPl2x       " Remove surrounding double quote

nnoremap <leader><c-p> :CtrlPMRUFiles<CR>

" autocompletion menu
"
" <enter> selects the highlighted menu item
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Run ctags on save
" autocmd BufWritePost * call system("ctags -R")
" }}}

" Plugin Configurations {{{

" Airline {{{
"let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
let g:airline_theme='gruvbox'
" }}}

" CtrlP {{{
"  'c' - the directory of the current file.
"  'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr
"  'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
"  0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:40,results:40'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git'
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

" ShellCheck {{{
autocmd Filetype sh set makeprg=shellcheck\ -f\ gcc\ % tabstop=4 sts=4 sw=4 et smarttab

" Syntactic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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

let &runtimepath.=',~/.vim/bundle/ale'

filetype plugin indent on
syntax on

command! PrettifyJSON %!python -m json.tool
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

function! SetupEnvironment()
  let l:path = expand('%:p')
  if l:path =~ 'zattoo'
    autocmd Filetype javascript set tabstop=4 sts=4 sw=4 et smarttab 
  endif
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()


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


