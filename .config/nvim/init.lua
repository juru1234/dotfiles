-- Automatically install vimplug
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
	vim.cmd('silent !curl -fLo ' ..
		data_dir ..
		'/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.o.runtimepath = vim.o.runtimepath
	vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- vim plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'takac/vim-hardtime'
Plug 'morhetz/gruvbox'
-- neovim plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'j-hui/fidget.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug('ibhagwan/fzf-lua', { branch = 'main' })
Plug 'ggandor/leap.nvim'
Plug 'stevearc/oil.nvim'
vim.call('plug#end')

require('helpers')
require('keymaps')

-- Use the gruvbox color scheme
vim.cmd("let g:gruvbox_transparent_bg = 1")
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
vim.cmd('colorscheme gruvbox')

-- Use osc52 as clipboard provider
vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
      },
      paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
      },
}

-- Enable the LSP and use it with nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')
require 'lspconfig'.bashls.setup {
	filetypes = { "sh", "bash", "zsh" }
}

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'bashls' }

local rust_analyzer_settings = {
	["rust-analyzer"] = {
		check = {
			command = "clippy",
		},
	}
}

for _, lsp in ipairs(servers) do
	if lsp == "rust_analyzer" then
		lspconfig[lsp].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = rust_analyzer_settings,
		}
	else
		lspconfig[lsp].setup {
			capabilities = capabilities,
		}
	end
end

-- nvim-cmp: completion engine plugin for neovim
-- used by LSP
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
		['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		["TAB"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		["S-TAB"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
	},
}

-- Show the status of the LSP bottom right
require "fidget".setup()
-- file explorer
require("oil").setup()
-- statusline
require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'gruvbox',
		component_separators = '|',
		section_separators = '',
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { { 'filename', path = 1 } },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	}, }

-- fast motions
require('leap').create_default_mappings()
vim.keymap.set('n', 's', function()
	require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)

-- hardtime
vim.cmd("let g:hardtime_timeout = 300")
vim.cmd("let g:hardtime_default_on = 1")

-- To ALWAYS use the clipboard for ALL operations
-- (instead of interacting with the "+" and/or "*" registers explicitly):
vim.opt.clipboard = "unnamedplus"

-- abbreviations
vim.cmd(':autocmd FileType c :iabbrev <buffer> pr@ pr_info("%s:\\n", __func__);<Esc>F\\i')

-- Set Terminal automatically to insert mode
-- and hide line numbers in terminal mode
vim.cmd('autocmd BufEnter,BufNew term://* startinsert')
vim.cmd('autocmd BufEnter,BufNew term://* set laststatus=0')
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber nobuflisted')

vim.cmd('set shell=/usr/bin/zsh')
vim.cmd('set list')
vim.cmd('set listchars=tab:*\\ ,eol:¬,trail:~')
vim.cmd('set cmdheight=1')
vim.wo.number = true
vim.wo.relativenumber = true
