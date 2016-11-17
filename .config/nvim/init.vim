"Brendan Roy's .vimrc
call plug#begin('~/.config/nvim/')

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "Golang autocompetion, go fmt on write, etc
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "async keyword completion
Plug 'zchee/deoplete-jedi' "python autocompletes with deoplete
Plug 'neomake/neomake' "syntax check & lint

Plug 'vim-airline/vim-airline' "statusline prettifier
Plug 'vim-airline/vim-airline-themes' "statusline prettifier
Plug 'kchmck/vim-coffee-script' "coffee highlighting and completion
Plug 'sukima/xmledit' "xml tag completion

Plug 'easymotion/vim-easymotion' "jump around vim with leader leader
Plug 'airblade/vim-gitgutter' "Shows file diff while editing
Plug 'tpope/vim-fugitive' "Git plugin
Plug 'tpope/vim-eunuch'   "QoL commands like :SudoWrite
Plug 'christoomey/vim-tmux-navigator' "Navigagte vim splits like tmux
Plug 'mileszs/ack.vim' "use ack in vim
Plug 'ctrlpvim/ctrlp.vim' "ctrl p fuzzy search
call plug#end()

filetype plugin indent on

"Beautiful Syntax highlighting
colorscheme jellybeans

" Always show statusline
set laststatus=2

" Use Deoplete.
let g:deoplete#enable_at_startup = 1

" Let <Tab> also do completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_embers'

"Additional config for gitgutter
set updatetime=250
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_column_always = 1

"Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" ctrlp
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlP'

"Make vim be friends with tmux (arrows)
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"General settings
filetype off
set nocompatible
filetype indent plugin on
syntax on
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
set notimeout ttimeout ttimeoutlen=200
map Y y$
set whichwrap+=<,>,h,l,[,]
set mouse=a "mostly for scrolling, text selection

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
au FileType html,css,scss,scss.css,javascript setl sw=2 ts=2 sts=2

" Gray column at 80 chars
hi ColorColumn guibg=#242424 ctermbg=234
set colorcolumn=80

" Prefer ag for ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack!


"when using :sb[next|previous], don't make a new window if one already
"exists.
set switchbuf=usetab

set fillchars="fold: "
set foldmethod=indent
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

"Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"system copy and paste binds
map <C-y> "+y
map <C-p> "+p

"Swap Buffers fastlike
map <C-Right> :bnext <CR>
map <C-Left> :bprevious <CR>

"quicky close buffers
map <C-w> :bd <CR>

"Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
