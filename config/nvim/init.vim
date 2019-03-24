"Brendan Roy's .vimrc
let g:uname = system("uname -s")
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe' "Autocompletion.
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "Golang autocompetion, go fmt on write, etc

Plug 'neomake/neomake'
Plug 'jaawerth/nrun.vim'

Plug 'tell-k/vim-autopep8'
Plug 'dag/vim-fish' "fish syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim' "typescript highlighting
Plug 'tpope/vim-rails'
Plug 'suan/vim-instant-markdown' "opens markdown files in a browser window
Plug 'othree/html5.vim' " html5 completion and syntax and and formatting
Plug 'sheerun/vim-polyglot' " catchall completion and syntax

Plug 'vim-airline/vim-airline' "statusline prettifier
Plug 'vim-airline/vim-airline-themes' "statusline prettifier
Plug 'kchmck/vim-coffee-script' "coffee highlighting and completion

Plug 'easymotion/vim-easymotion' "jump around vim with leader leader
Plug 'airblade/vim-gitgutter' "Shows file diff while editing
Plug 'tpope/vim-fugitive' "Git plugin
Plug 'tpope/vim-eunuch'   "QoL commands like :SudoWrite
Plug 'tpope/vim-abolish'  "case respectful search and replace via :%S
Plug 'christoomey/vim-tmux-navigator' "Navigagte vim splits like tmux
"Plug 'mileszs/ack.vim' "use ack in vim
Plug 'jremmen/vim-ripgrep'
" Plug 'ctrlpvim/ctrlp.vim' "ctrl p fuzzy search - disabled in favor of fzf+rg
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' "fzf extensions for vim
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'


call plug#end()

filetype plugin indent on

"Beautiful Syntax highlighting
colorscheme jellybeans

" Always show statusline
set laststatus=2

" neomake onsave
call neomake#configure#automake('w')
" make neomake show errors in error list
let g:neomake_open_list = 2

let g:neomake_javascript_eslint_exe = 'yarn bin eslint'
let g:neomake_vue_eslint_exe = system("yarn bin eslint | tr -d '\n'")

"" Use Deoplete.
"let g:deoplete#enable_at_startup = 1

" YCM config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path = 'python'
let g:ycm_keep_logfiles = 1

" vim-go
let g:go_fmt_experimental = 1
let g:go_fmt_command = "goimports"

" Let <Tab> also do completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_embers'

"Additional config for gitgutter
set updatetime=250
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set signcolumn=yes

""Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_typescript_tslint_exe = 'npx tslint'
let g:syntastic_vue_checkers = ['eslint']
let g:syntastic_vue_eslint_exe = 'yarn lint'
let g:syntastic_vue_eslint_exec = 'ls'

" ignore: line len, blank linke after class decl, assigned lambdas,
" complex functions, arithmetic whitespace
let g:syntastic_python_flake8_args='--ignore=E501,E309,E731,C901,E226'

" flake8-vim
let g:PyFlakeDisabledMessages = 'E501,E309,E731,C901'

" fzf
nnoremap <c-p> :FZF<cr>

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-i> :TmuxNavigateUp<cr>
nnoremap <silent> <C-j> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-k> :TmuxNavigateDown<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

"General settings
filetype off
set nocompatible
filetype indent plugin on
syntax on
set autowrite
set hidden
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set cmdheight=2
set number
set tenc=utf8
set ttyfast
set notimeout ttimeout ttimeoutlen=200
set whichwrap+=<,>,h,l,[,]
set mouse=a "mostly for scrolling, text selection

" for when you hold shift too long, and you're trying to type :wq
cabbrev W w
cabbrev Q q
cabbrev Wq wq

"Tab completion on commands
set wildmode=longest,full
set wildmenu

" tell vim where to put its backup and swap files
"set backupdir=~/.vim_backups
"set dir=~/.vim_backups
" or just not to back up at all
set nobackup
set noswapfile

"Indentation
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
au FileType java setl sw=8 ts=4 sts=8 expandtab!
au FileType html,css,scss,scss.css,json,typescript,javascript,coffee,ruby,eruby,yaml setl sw=2 ts=2 sts=2

let g:html_indent_inctags = 'dd'

" Gray column at 80 chars
hi ColorColumn guibg=#242424 ctermbg=234
let &colorcolumn="80,".join(range(100,120),",").join(range(120,999),",")

"when using :sb[next|previous], don't make a new window if one already
"exists.
set switchbuf=usetab

"Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

"Create required parent directores on buffer write
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

"system copy and paste binds
" disabling these for now in favour of setting the default clipboard to the
" system clipboard.
set clipboard=unnamed,unnamedplus

"map <C-y> "+y
"map <C-p> "+p
map <Leader>p gg"_dGP

"Swap Buffers fastlike
nnoremap <silent> <C-o> :bnext <CR>
nnoremap <silent> <C-u> :bprevious <CR>

"quicky close buffers
map <C-w> :bd <bar> redraw! <CR>

" Map goto to something useful
map <Leader>f :YcmCompleter GoTo <CR>

" 60% keyboard not so crash hot so far
map i <Up>
map j <Left>
map k <Down>
noremap h i

"Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

set fillchars="fold: "
set foldmethod=indent
autocmd Syntax c,cpp,vim,xml,html,xhtml,djangohtml setlocal foldmethod=syntax
set foldlevel=99
"
" open all folds, then close the top level folds only
autocmd BufReadPost * :silent! %foldo! "| silent! %foldc
