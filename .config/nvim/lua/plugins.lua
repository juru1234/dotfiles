-- Attention:
-- this file isn't use since lazy.nvim requires LuaJIT
-- Instead we use vimplug in main.lua

vim.g.mapleader = " "
require("lazy").setup({
	{ url = "https://github.com/neovim/nvim-lspconfig" },
	-- Autocompletion plugin
	{ url = 'https://github.com/hrsh7th/nvim-cmp' },
	-- LSP source for nvim-cmp
	{ url = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
	{
		url = 'https://github.com/L3MON4D3/LuaSnip',
		dependencies = { "https://github.com/rafamadriz/friendly-snippets" },
	},
	-- LuaSnip for nvim-cmp
	{ url = 'https://github.com/saadparwaiz1/cmp_luasnip' },
	{ url = 'https://github.com/morhetz/gruvbox' },
	{
		url = "https://github.com/nvim-telescope/telescope.nvim",
		dependencies = { url = "https://github.com/nvim-lua/plenary.nvim" }
	},
	{ url = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		url = "https://github.com/windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	},
	-- Show LSP info bottom right
	{ url = 'https://github.com/j-hui/fidget.nvim',               tag = "legacy" },
	{ url = 'https://github.com/airblade/vim-gitgutter' },
	{ url = 'https://github.com/tpope/vim-fugitive' },
	{ url = 'https://github.com/roxma/vim-tmux-clipboard' },
	{ url = 'https://github.com/ggandor/leap.nvim' },
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	}
})
