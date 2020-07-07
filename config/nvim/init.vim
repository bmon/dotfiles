".Brendan Roy's .vimrc
let g:uname = system("uname -s")
call plug#begin('~/.local/share/nvim/plugged')

" coc is a language server client, configurable using :CocConfig
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" vim-autoformat will attempt to format source files using well known formatters, such as `clang-format`
Plug 'chiel92/vim-autoformat'

Plug 'suan/vim-instant-markdown' "opens markdown files in a browser window
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "Golang autocompetion, go fmt on write, etc

Plug 'ap/vim-css-color' "preview colors in source while editing

Plug 'vim-airline/vim-airline' "statusline prettifier
Plug 'vim-airline/vim-airline-themes' "statusline prettifier

Plug 'easymotion/vim-easymotion' "jump around vim with leader leader
Plug 'airblade/vim-gitgutter' "Shows file diff while editing

Plug 'tpope/vim-fugitive' "Git plugin
Plug 'tpope/vim-rhubarb'  "Github integration for fugitive

Plug 'aymericbeaumet/vim-symlink' "Edit symlink targets directly
Plug 'tpope/vim-eunuch'   "QoL commands like :SudoWrite
Plug 'tpope/vim-abolish'  "case respectful search and replace via :%S
Plug 'christoomey/vim-tmux-navigator' "Navigagte vim splits like tmux

Plug 'jremmen/vim-ripgrep' "provides :Rg for calling ripgrep within vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fantastic fuzzy filename completion
Plug 'junegunn/fzf.vim' "fzf extensions for vim

Plug 'flazz/vim-colorschemes'
call plug#end()

filetype plugin indent on

"Beautiful Syntax highlighting
colorscheme jellybeans

" Always show statusline
set laststatus=2

"" vim-go
""let g:go_fmt_experimental = 1
"let g:go_fmt_command = "goimports"
"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'
"" vim-go bindings clash with others, so I disable them all and re-enable those I care for
"let g:go_def_mapping_enabled=0
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Let <Tab> be used to browse completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Pressing enter with completion menu visible will accept the current
" completion. I have an issue/bug with coc that will delete a word after
" the completion when using C-y (the usual map to accept a compltion).
" Instead I have mapped it to ESC which will close the completion menu.
" Thus we rely on C-n and C-p to populate a completion as it is selected.
"inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
"inoremap <expr> <CR>    pumvisible() ? "\<ESC>" : "\<CR>"
inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <CR> json_encode(complete_info())
"
" For some reason using <Up> and <Down> is not the same as <C-n> and <C-p>
" when browsing completions. Maybe to do with coc?
inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"

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
nnoremap <C-p> :FZF<cr>

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
"set mouse=a "mostly for scrolling, text selection
set pyxversion=3

" Use very magic matching by default on search and replace
nnoremap / /\v
cnoremap %s/ %s/\v

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
autocmd FileType html,css,scss,scss.css,json,typescript,javascript,coffee,ruby,eruby,yaml,apex setl sw=2 ts=2
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType go setl noexpandtab

" Gray column at 80 chars
hi ColorColumn guibg=#242424 ctermbg=234
let &colorcolumn="80,".join(range(100,120),",").join(range(120,999),",")

"when using :sb[next|previous], don't make a new window if one already exists.
set switchbuf=usetab

" call :Autoformat on save. This will try to call a formatter for the
" current file, but if it doesn't exist will fallback to the options
" configured below.
au BufWrite * :Autoformat

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 1

let g:formatdef_gofmt_1 = '"gofmt | goimports"'

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
set clipboard=unnamedplus

" leader p to replace the entire buffer
map <Leader>p gg"_dGP

"Swap Buffers fastlike
nnoremap <silent> <C-o> :bnext <CR>
nnoremap <silent> <C-u> :bprevious <CR>

"Fix syntax highliging errors when switching buffers
autocmd BufEnter * :syntax sync fromstart

"quicky close buffers
map <C-w> :bd <CR>
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

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
