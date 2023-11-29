".Brendan Roy's .vimrc
call plug#begin('~/.local/share/nvim/plugged')
" Code editing
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

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
Plug 'udalov/kotlin-vim'

call plug#end()

""" Initialise colorscheme early to aid nvim-lsp colouring
set termguicolors
colorscheme highlite
highlight PmenuSel ctermfg=162 guifg=#d70087

""" nvim-lsp
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

lua << EOF
    -- Setup nvim-cmp.
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end,
        },
            window = {},
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<TAB>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                 { name = 'nvim_lsp' },
            }, {
                { name = 'buffer' },
            })
    })

    -- Setup lspconfig.
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lsp = require "lspconfig"
	lsp.gopls.setup{
        capabilities = capabilities,
        settings = {
            gopls = {
                buildFlags = {"-tags=endtoend"},
                gofumpt = true,
                usePlaceholders = true,
                allExperiments = true,
    			["local"] = "github.com/mx51",
                staticcheck = true,
                analyses = {
                    ST1000 = false,  -- Incorrect or missing package comment
                    ST1003 = false,  -- Poorly chosen identifier (TsMs)
                }
            }
        }
    }

    lsp.clangd.setup{capabilities = capabilities}
    lsp.tsserver.setup{capabilities = capabilities}
    lsp.vuels.setup{capabilities = capabilities}

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = '',
        },
      }
    )

    vim.api.nvim_create_augroup('AutoFormatting', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      group = 'AutoFormatting',
      callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = {only = {"source.organizeImports"}}
        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
              vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
          end
        end
        vim.lsp.buf.format({async = false})
      end,
    })

EOF

""" python3 support
let g:python3_host_prog="/usr/sbin/python"

""" map diagnostic keybinds
nnoremap <leader>n :lua vim.diagnostic.goto_next()<cr>
nnoremap <leader>N :lua vim.diagnostic.goto_prev()<cr>

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
let g:formatters_vue = ['stylelint']

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

""" Switch buffers with CTRL U or CTRL O
nnoremap <silent> <C-o> :bnext <CR>
nnoremap <silent> <C-u> :bprevious <CR>
nnoremap <C-w> :bd <CR>
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()
autocmd BufEnter * :syntax sync fromstart " Fix syntax highliging errors when switching buffers


""" Indendation and filetype maps
set shiftwidth=4 tabstop=4 expandtab
autocmd FileType html,css,scss,scss.css,json,typescript,javascript,coffee,ruby,eruby,yaml,apex,vue setl sw=2 ts=2
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType go setl noexpandtab

" Gray column at 80, 100 and 120 chars
"hi ColorColumn guibg=#0a0a0a ctermbg=234
"let &colorcolumn="80,".join(range(100,120),",").join(range(120,999),",")

""" Code folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

set fillchars="fold: "
set foldmethod=indent
set foldlevel=99

set clipboard+=unnamedplus
""" WSL System Copy Paste
if executable('win32yank')
    let g:clipboard = {
              \   'name': 'win32yank-wsl',
              \   'copy': {
              \      '+': 'win32yank -i --crlf',
              \      '*': 'win32yank -i --crlf',
              \    },
              \   'paste': {
              \      '+': 'win32yank -o --lf',
              \      '*': 'win32yank -o --lf',
              \   },
              \   'cache_enabled': 0,
              \ }
endif

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
let g:netrw_fastbrowse = 0 " Close netrw buffer once you open a file
set mouse= " disable mouse support

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
