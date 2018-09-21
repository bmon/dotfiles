"Brendan Roy's .vimrc
let g:uname = system("uname -s")
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe' "Autocompletion.
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "Golang autocompetion, go fmt on write, etc
"Plug 'andviro/flake8-vim' "python flake checking - disabled due to incompatability with YCM
Plug 'vim-syntastic/syntastic'
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
Plug 'junegunn/fzf' "fzf search
Plug 'junegunn/fzf.vim' "fzf extensions for vim
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'


call plug#end()

filetype plugin indent on

"Beautiful Syntax highlighting
colorscheme jellybeans

" Always show statusline
set laststatus=2

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

let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_typescript_tslint_exe = 'npx tslint'

" ignore: line len, blank linke after class decl, assigned lambdas,
" complex functions, arithmetic whitespace
let g:syntastic_python_flake8_args='--ignore=E501,E309,E731,C901,E226'

" flake8-vim
let g:PyFlakeDisabledMessages = 'E501,E309,E731,C901'

" fzf
nnoremap <c-p> :FZF<cr>

"" ctrlp
"let g:ctrlp_map = '<c-o>'
"let g:ctrlp_cmd = 'CtrlP'
"
"" use ripgrep as default in ctrlp
"if executable('rg')
"  set grepprg=rg\ --color=never
"  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
"  let g:ctrlp_user_command = 'echo %s >> ctrlpsearches.txt && rg . --files --color=never --glob ""' " debugging
"  " should be more than fast enough to allow for no cache requirement
"  let g:ctrlp_use_caching = 0
"endif

"" make ctrl-p ignore spaces in search query
"let g:ctrlp_abbrev = {
"  \ 'gmode': 'i',
"  \ 'abbrevs': [
"    \ {
"      \ 'pattern': ' ',
"      \ 'expanded': '',
"      \ 'mode': 'pfrz',
"    \ },
"    \ ]
"  \ }

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
let &colorcolumn="80,".join(range(100,119),",").join(range(120,999),",")

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

"Swap Buffers fastlike
map <C-Right> :bnext <CR>
map <C-Left> :bprevious <CR>

"quicky close buffers
map <C-w> :bd <bar> redraw! <CR>

" Map goto to something useful
map <Leader>f :YcmCompleter GoTo <CR>

" I should really get used to using vim properly...
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Right> <nop>
inoremap <Left> <nop>

"Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

set fillchars="fold: "
set foldmethod=indent
autocmd Syntax c,cpp,vim,xml,html,xhtml,djangohtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl,djangohtml normal zR
"
" open all folds, then close the top level folds only
autocmd BufReadPost * :silent! %foldo! "| silent! %foldc