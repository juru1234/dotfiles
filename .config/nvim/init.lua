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
require('lsp')

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
-- To ALWAYS use the clipboard for ALL operations
-- (instead of interacting with the "+" and/or "*" registers explicitly):
vim.opt.clipboard = "unnamedplus"

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
		lualine_c = { { 'filename', path = 1 } },
	},
}

-- fast motions
require('leap').create_default_mappings()
vim.keymap.set('n', 's', function()
	require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)

-- hardtime
vim.cmd("let g:hardtime_timeout = 300")
vim.cmd("let g:hardtime_default_on = 1")

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
