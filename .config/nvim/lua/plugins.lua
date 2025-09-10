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
Plug 'takac/vim-hardtime'
Plug 'lervag/vimtex'
-- neovim plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'j-hui/fidget.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug('ibhagwan/fzf-lua', { branch = 'main' })
Plug 'ggandor/leap.nvim'
Plug 'stevearc/oil.nvim'
Plug('catppuccin/nvim', { as =  'catppuccin' })
Plug('lewis6991/gitsigns.nvim', { commit = '60676707b6a5fa42369e8ff40a481ca45987e0d0' })
Plug 'kdheepak/lazygit.nvim'
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install', ['for'] = { 'markdown' } })

vim.call('plug#end')
