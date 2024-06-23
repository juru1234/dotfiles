------------------------------------------------------------------
-- Ensure that the lazy.nvim plugin manager is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Install Plugins and import keymaps
-- Both located in ~/.config/nvim/lua
require('plugins')
require('keymaps')
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Use the gruvbox scheme
vim.cmd("let g:gruvbox_transparent_bg = 1")
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
vim.cmd('colorscheme gruvbox')
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Enable the LSP and use it with nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls' }

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
-------------------------------------------------------------------

-------------------------------------------------------------------
-- LuaSnip provides default VSCode code snippets and
-- own ones located in ~/.config/nvim/snippets
local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
-------------------------------------------------------------------

-------------------------------------------------------------------
-- nvim-cmp: completion engine plugin for neovim
-- used by LSP and LuaSnip
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
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
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		["S-TAB"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}
-------------------------------------------------------------------

-------------------------------------------------------------------
-- A super powerful autopair plugin
-- Automatically closes brackets and so on...
require('nvim-autopairs').setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Show the status of the LSP bottom right
require "fidget".setup {
	window = {
		blend = 0,
	},
}
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Plugin that highlights code in color
require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "javascript", "typescript",
		"lua", "vim", "json", "html", "rust", "tsx" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
-------------------------------------------------------------------

require('telescope').setup({
	defaults = {
		--sorting_strategy = "ascending",
		--layout_strategy = "horizontal",
		--border = false,
		prompt_title = "",
		results_title = "",
		preview_title = "",
		--prompt_prefix = "",
		selection_caret = "",
		entry_prefix = "",
		multi_icon = "",
		color_devicons = false,
		preview = { msg_bg_fillchar = ' ' },
		layout_config = {
			width = 9999,
			height = 9999,
			preview_width = { 0.6, max = 9999, min = 0 },
		},
	}
})

-------------------------------------------------------------------
Harpoon = require("harpoon")
Harpoon:setup()
-------------------------------------------------------------------

-------------------------------------------------------------------
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
		lualine_c = { {'filename', path=1} },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	}, }
-------------------------------------------------------------------

-------------------------------------------------------------------
require('leap').create_default_mappings()
vim.keymap.set('n', 's', function()
	require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)
-------------------------------------------------------------------

-------------------------------------------------------------------
local function paste()
	return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
end

vim.g.clipboard = {
	name = 'OSC 52',
	copy = {
		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
	},
	paste = {
		['+'] = paste,
		['*'] = paste,
	},
}
vim.opt.clipboard = "unnamedplus"
------------------------------------------------------------------

------------------------------------------------------------------
-- Set Terminal automatically to insert mode
-- and hide line numbers in terminal mode
vim.cmd('autocmd BufEnter,BufNew term://* startinsert')
vim.cmd('autocmd BufEnter,BufNew term://* set laststatus=0')
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber nobuflisted')
------------------------------------------------------------------

-------------------------------------------------------------------
vim.cmd('set shell=/usr/bin/zsh')
vim.cmd('set list')
vim.cmd('set listchars=tab:*\\ ,eol:¬,trail:~')
vim.cmd('set cmdheight=1')
vim.wo.number = true
vim.wo.relativenumber = true
-------------------------------------------------------------------
