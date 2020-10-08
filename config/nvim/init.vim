".Brendan Roy's .vimrc
call plug#begin('~/.local/share/nvim/plugged')
" Code editing
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim' " Better error highlighting for nvim lsp
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Vim Functionality
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "fantastic fuzzy filename completion
Plug 'junegunn/fzf.vim' "fzf extensions for vim
Plug 'christoomey/vim-tmux-navigator' "Navigagte vim splits like tmux
Plug 'chiel92/vim-autoformat' "Autoformat some files like .proto with clang-format
Plug 'tpope/vim-fugitive' "Git plugin
Plug 'tpope/vim-rhubarb'  "Github integration for fugitive
Plug 'tpope/vim-eunuch'   "QoL commands like :SudoWrite
Plug 'tpope/vim-abolish'  "case respectful search and replace via :%S
Plug 'ncm2/float-preview.nvim' "Floating completion pane

" Visuals
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Iron-E/nvim-highlite'
"Plug 'flazz/vim-colorschemes'

call plug#end()

""" Initialise colorscheme early to aid nvim-lsp colouring
set termguicolors
colorscheme highlite

""" nvim-lsp
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

lua << EOF
	local nvim_lsp = require'nvim_lsp'

	nvim_lsp.gopls.setup{
	    settings = {
	        gopls = {
	            buildFlags = {"-tags=endtoend"},
	            gofumpt = true,
                usePlaceholders = true,
                allExperiments = true,
				["local"] = "github.com/mx51",
                staticcheck = true,
	        }
	    },
	    on_attach=require'diagnostic'.on_attach
	}
	nvim_lsp.vimls.setup{}
	nvim_lsp.clangd.setup{}

	function goimports(timeoutms)
	  local context = { source = { organizeImports = true } }
	  vim.validate { context = { context, "t", true } }

	  local params = vim.lsp.util.make_range_params()
	  params.context = context

	  local method = "textDocument/codeAction"
	  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
	  if resp and resp[1] then
	    local result = resp[1].result
	    if result and result[1] then
	      local edit = result[1].edit
	      vim.lsp.util.apply_workspace_edit(edit)
	    end
	  end

	  vim.lsp.buf.formatting()
	end
EOF

autocmd BufWritePre *.go lua goimports(1000)

set omnifunc=v:lua.vim.lsp.omnifunc

""" nvim-diagnostic for better inline lsp errors

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ''

nnoremap <leader>n :NextDiagnosticCycle<cr>
nnoremap <leader>N :PrevDiagnosticCycle<cr>

""" fzf
nnoremap <C-p> :Files<cr>

""" tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

""" vim-autoformat
let ftToIgnore = ['go']
autocmd BufWritePre * if index(ftToIgnore, &ft) < 0 | :Autoformat

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 1

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_embers'
let g:airline_section_z='%p%%' " Don't bother with cols, max lineno, etc
let g:airline#extensions#whitespace#checks = [] " these checks aren't useful for me

""" gitgutter
set updatetime=250
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

""" Omnicompletion on typeing
function! OpenCompletion()
    if &ft =~ 'sql'
        return
    endif

    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
        call feedkeys("\<C-x>\<C-o>", "n")
    endif
endfunction

autocmd InsertCharPre * call OpenCompletion()
set completeopt+=menuone,noinsert,noselect
set completeopt-=preview

""" Switch buffers with CTRL U or CTRL O
nnoremap <silent> <C-o> :bnext <CR>
nnoremap <silent> <C-u> :bprevious <CR>
nnoremap <C-w> :bd <CR>
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()
autocmd BufEnter * :syntax sync fromstart " Fix syntax highliging errors when switching buffers


""" Indendation and filetype maps
set shiftwidth=4 tabstop=4 expandtab
autocmd FileType html,css,scss,scss.css,json,typescript,javascript,coffee,ruby,eruby,yaml,apex setl sw=2 ts=2
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType go setl noexpandtab

" Gray column at 80, 100 and 120 chars
hi ColorColumn guibg=#0a0a0a ctermbg=234
let &colorcolumn="80,".join(range(100,120),",").join(range(120,999),",")


""" Code folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

set fillchars="fold: "
set foldmethod=indent
set foldlevel=99

""" General settings
set hidden     " Never unload buffers, instead hide them. This allows switching buffers with unsaved changes
set ignorecase " Default ignore case when searching
set smartcase  " Override ignorecase if a search contains any uppercase characters
set confirm    " Instead of failing to quit when unsaved, ask if you want to save
set number     " Add line numbers
set notimeout ttimeout ttimeoutlen=200 " Wait 200ms for key combos
set whichwrap+=<,>,[,] " which buttons can wrap lines
set nobackup           " no backup files or folder
set noswapfile         " no swap files
set wildmode=longest,full "Tab completion on commands
set wildmenu              " ^
set hlsearch " Don't highlight search matches

" Use very magic matching by default on search and replace
nnoremap / /\v
cnoremap %s/ %s/\v

" text deleted with `x` goes to the black hole register (not yanked)
nnoremap x "_x

" for when you hold shift too long, and you're trying to type :wq
cabbrev W w
cabbrev Q q
cabbrev Wq wq

" open this config file
cabbrev Config e ~/.config/nvim/init.vim

