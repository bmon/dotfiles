"Brendan Roy's .vimrc

set nocompatible              " be improved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'gmarik/Vundle.vim' "let Vundle manage Vundle, required
Plugin 'Valloric/YouCompleteMe' "Autocompletion
Plugin 'vim-airline/vim-airline' "statusline prettifier
Plugin 'vim-airline/vim-airline-themes' "statusline prettifier
Plugin 'scrooloose/syntastic' "Syntax highlighting and errors
Plugin 'airblade/vim-gitgutter' "Shows file diff while editing
Plugin 'tpope/vim-unimpaired' "Extra commands
Plugin 'tpope/vim-fugitive' "Git plugin
Plugin 'tpope/vim-eunuch'   "QoL commands like :SudoWrite
Plugin 'fatih/vim-go'       "Golang autocompetion, go fmt on write, etc
Plugin 'kchmck/vim-coffee-script' "coffee highlighting and completion
Plugin 'sukima/xmledit' "xml tag completion
Plugin 'christoomey/vim-tmux-navigator' "Navigagte vim splits like tmux

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Beautiful Syntax highlighting
colorscheme jellybeans

"YCM Config
"Don't pester about ycm extra conf.
let g:ycm_confirm_extra_conf = 0
"Close preview window after we select an option
let g:ycm_autoclose_preview_window_after_completion = 1

" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

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

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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


"Enable mouse scrolling, but disable positioning
set mouse=a
nmap <LeftMouse> <nop>
imap <LeftMouse> <nop>
vmap <LeftMouse> <nop>

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


"when using :sb[next|previous], don't make a new window if one already
"exists.
set switchbuf=usetab

set fillchars="fold: "
set foldmethod=indent
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

"Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"Quick toggle for paste mode
set pastetoggle=<F4>

"Swap Buffers fastlike
map <C-Right> :bnext <CR>
map <C-Left> :bprevious <CR>

"Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
