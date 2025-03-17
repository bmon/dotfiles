-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.api.nvim_echo({
		{ "lazy.nvim not found, bootstrapping environment..." },
	}, true, {})

	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.keymap.set("n", "<C-p>", ":Files<CR>", { silent = true })
vim.keymap.set("n", "<C-o>", ":bnext <CR>", { silent = true })
vim.keymap.set("n", "<C-u>", ":bprevious <CR>", { silent = true })
vim.keymap.set("n", "<C-w>", ":bdelete <CR>")
-- remove diagnostic default mappings preventing C-w from being awaiting another key
vim.keymap.del("n", "<C-w>d")
vim.keymap.del("n", "<C-w><C-d>")

-- lsp keybindings
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
vim.keymap.set("n", "<c]>", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true })
vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
vim.keymap.set("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { silent = true })
vim.keymap.set("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", { silent = true })

vim.keymap.set("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true })
vim.keymap.set("n", "<leader>N", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true })

vim.keymap.set("n", "<leader>c", "<cmd>vert belowright Copilot panel<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy update<CR>", { silent = true })

--""" Code folding
vim.keymap.set("n", "<Space>", "@=(foldlevel('.')?'za':'<Space>')<CR>", { silent = true })
vim.keymap.set("v", "<Space>", "zf", { silent = true })

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldlevel = 99

vim.cmd(
	"autocmd FileType html,css,scss,scss.css,json,typescript,javascript,coffee,ruby,eruby,yaml,apex,vue setl sw=2 ts=2"
)
vim.cmd("autocmd FileType go setl noexpandtab")
vim.cmd("set hidden")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set confirm")
vim.cmd("set number")
vim.cmd("set notimeout ttimeout ttimeoutlen=200")
vim.cmd("set whichwrap+=<,>,[,]")
vim.cmd("set nobackup")
vim.cmd("set noswapfile")
vim.cmd("set wildmode=longest,full")
vim.cmd("set wildmenu")
vim.cmd("set mouse=")
vim.cmd("set shiftwidth=4 tabstop=4 expandtab")
vim.cmd("colorscheme habamax")
vim.cmd("cabbrev Config e ~/.config/nvim/init.lua")

-- Setup clipboard
vim.cmd("set clipboard+=unnamedplus")
-- only override clipboard settings if we're in WSL
if vim.fn.executable("clip.exe") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "neovim/nvim-lspconfig" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-vsnip" },
		{ "hrsh7th/vim-vsnip" },
		{ "github/copilot.vim" },

		{
			"vim-airline/vim-airline",
			init = function()
				vim.g["airline#extensions#tabline#enabled"] = 1
				vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
				vim.g["airline_theme"] = "base16_embers"
				vim.g["airline_section_z"] = "%p%%" -- Don't bother with cols, max lineno, etc
			end,
		},
		{ "vim-airline/vim-airline-themes" },

		{ "junegunn/fzf" },
		{ "junegunn/fzf.vim" }, --fzf extensions for vim
		{ "christoomey/vim-tmux-navigator" }, --Navigagte vim splits like tmux

		{
			"stevearc/conform.nvim",
			opts = {
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
					quiet = false,
				},
				formatters_by_ft = {
					go = { "goimports", "gofumpt" },
					lua = { "stylua" },
					proto = { "clang-format" },
				},
			},
		},

		{ "tpope/vim-fugitive" }, --Git plugin
		{ "tpope/vim-rhubarb" }, --Github integration for fugitive
		{ "rhysd/conflict-marker.vim" }, --Git conflict markers
		{ "airblade/vim-gitgutter" },

		{ "tpope/vim-eunuch" }, --QoL commands like :SudoWrite
		{ "tpope/vim-abolish" }, --case respectful search and replace via :%S
		{ "ncm2/float-preview.nvim" }, --Floating completion pane
		{
			"RaafatTurki/hex.nvim", --Hex editing
			init = function()
				require("hex").setup()
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			init = function(plugin)
				require("nvim-treesitter.query_predicates")
			end,
			cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
			opts_extend = { "ensure_installed" },
			opts = {
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"diff",
					"html",
					"javascript",
					"json",
					"lua",
					"python",
					"tsx",
					"typescript",
					"go",
					"sql",
					"proto",
				},
			},
			---@param opts TSConfig
			config = function(_, opts)
				require("nvim-treesitter.configs").setup(opts)
			end,
		},
	},

	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Setup nvim-cmp.
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	window = {},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		-- ['<TAB>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp = require("lspconfig")
lsp.gopls.setup({
	capabilities = capabilities,
	settings = {
		gopls = {
			buildFlags = { "-tags=endtoend" },
			gofumpt = true,
			usePlaceholders = true,
			allExperiments = true,
			["local"] = "github.com/mx51",
			staticcheck = true,
			analyses = {
				ST1000 = false, -- Incorrect or missing package comment
				ST1003 = false, -- Poorly chosen identifier (TsMs)
			},
		},
	},
})
require("lspconfig").ts_ls.setup({ capabilities = capabilities })
require("lspconfig").vuels.setup({ capabilities = capabilities })
require('lspconfig').ruff.setup {
  on_attach = on_attach,
}
require('lspconfig').pyright.setup {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
}

local on_attach = function(client, bufnr)
  if client.name == 'ruff' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		prefix = "",
	},
})


