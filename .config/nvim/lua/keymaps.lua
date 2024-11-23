-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-left>', '<C-w>h')
map('n', '<C-down>', '<C-w>j')
map('n', '<C-up>', '<C-w>k')
map('n', '<C-right>', '<C-w>l')

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true }) -- open
map('t', '<Esc>', '<C-\\><C-n>')                   -- exit
map('t', '<C-left>', '<C-\\><C-n><C-w>h')
map('t', '<C-down>', '<C-\\><C-n><C-w>j')
map('t', '<C-up>', '<C-\\><C-n><C-w>k')
map('t', '<C-right>', '<C-\\><C-n><C-w>l')


vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.keymap.set("n", "<leader>f", require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>g", require('fzf-lua').grep_visual, { desc = "Fzf Grep" })
vim.keymap.set("n", "<leader>b", require('fzf-lua').buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>a", require('fzf-lua').args, { desc = "Fzf Arguments" })
vim.keymap.set("n", "<leader>d", require('fzf-lua').diagnostics_document, { desc = "Fzf Diagnostics" })
vim.keymap.set("n", "<leader>r", require('fzf-lua').lsp_references, { desc = "Fzf References" })
vim.keymap.set("n", "<leader>c", require('fzf-lua').lsp_code_actions, { desc = "Fzf Code Actions" })

--arglist
vim.keymap.set("n", "<Tab>", Cycle_arg_list)
vim.keymap.set("n", "<Leader>aa", ":ArgAdd<CR>")
vim.keymap.set('n', '<Leader>ap', ':lua vim.cmd("ArgAdd " .. vim.fn.input("position (1..n): "))<CR>')
vim.keymap.set("n", "<Leader>1", ":$argu 1<CR>")
vim.keymap.set("n", "<Leader>2", ":$argu 2<CR>")
vim.keymap.set("n", "<Leader>3", ":$argu 3<CR>")
vim.keymap.set("n", "<Leader>4", ":$argu 4<CR>")
vim.keymap.set("n", "<Leader>5", ":$argu 5<CR>")
vim.keymap.set("n", "<Leader>6", ":$argu 6<CR>")

vim.keymap.set('i', 'kj', "<Esc>")
vim.keymap.set('v', 'kj', "<Esc>")

-- automatically expand
vim.keymap.set('i', '(;', "(<CR>)<C-c>O<Tab>")
vim.keymap.set('i', '{;', "{<CR>}<C-c>O<Tab>")
vim.keymap.set('i', '[;', "[<CR>]<C-c>O<Tab>")
vim.keymap.set('i', '\'\'', "\'\'<Left>")
vim.keymap.set('i', '\"\"', "\"\"<Left>")
vim.keymap.set('i', '``', "``<Left>")
