".Brendan Roy's .vimrc
let g:uname = system("uname -s")
call plug#begin('~/.local/share/nvim/plugged')

" coc is a language server client, configurable using :CocConfig
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" vim-autoformat will attempt to format source files using well known formatters, such as `clang-format`
Plug 'bmon/vim-autoformat'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim' "typescript highlighting
Plug 'suan/vim-instant-markdown' "opens markdown files in a browser window
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "Golang autocompetion, go fmt on write, etc

Plug 'ap/vim-css-color' "preview colors in source while editing

Plug 'vim-airline/vim-airline' "statusline prettifier
Plug 'vim-airline/vim-airline-themes' "statusline prettifier

Plug 'easymotion/vim-easymotion' "jump around vim with leader leader
Plug 'airblade/vim-gitgutter' "Shows file diff while editing

Plug 'tpope/vim-fugitive' "Git plugin
Plug 'tpope/vim-rhubarb'  "Github integration for fugitive

Plug 'tpope/vim-eunuch'   "QoL commands like :SudoWrite
Plug 'tpope/vim-abolish'  "case respectful search and replace via :%S
Plug 'christoomey/vim-tmux-navigator' "Navigagte vim splits like tmux

Plug 'jremmen/vim-ripgrep' "provides :Rg for calling ripgrep within vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fantastic fuzzy filename completion
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
"call neomake#configure#automake('w')
" make neomake show errors in error list
let g:neomake_open_list = 2

let g:neomake_javascript_eslint_exe = system("yarn bin eslint | tr -d '\n'")
let g:neomake_vue_eslint_exe = system("yarn bin eslint | tr -d '\n'")


" vim-go
"let g:go_fmt_experimental = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Let <Tab> also do completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_embers'

"Additional config for gitgutter
set updatetime=250
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set signcolumn=yes

" flake8-vim
let g:PyFlakeDisabledMessages = 'E501,E309,E731,C901'

" fzf
nnoremap <c-p> :FZF<cr>

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

"General settings
"syntax on
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
set pyxversion=3

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
set shiftwidth=4 tabstop=4 expandtab
"au FileType java setl sw=8 ts=4 sts=8 expandtab!
au FileType html,css,scss,scss.css,json,typescript,javascript,coffee,ruby,eruby,yaml,apex setl sw=2 ts=2

let g:html_indent_inctags = 'dd'

" Gray column at 80 chars
hi ColorColumn guibg=#242424 ctermbg=234
let &colorcolumn="80,".join(range(100,120),",").join(range(120,999),",")

"when using :sb[next|previous], don't make a new window if one already
"exists.
set switchbuf=usetab

" call :Autoformat on save. This will try to call a formatter for the
" current file, but if it doesn't exist will fallback to the options
" configured below.
au BufWrite * :Autoformat

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 1

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

" copy and paste into system clipboard.
set clipboard=unnamed ",unnamedplus

" leader p to replace the entire buffer
map <Leader>p gg"_dGP

"Swap Buffers fastlike
nnoremap <silent> <C-o> :bnext <CR>
nnoremap <silent> <C-u> :bprevious <CR>

"quicky close buffers
map <C-w> :bd <bar> redraw! <CR>

" Map goto to something useful
map <Leader>d :call CocAction('jumpDefinition') <CR>

"Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

set fillchars="fold: "
set foldmethod=indent
set foldlevel=99

" open all folds, then close the top level folds only
autocmd BufReadPost * :silent! %foldo! "| silent! %foldc
