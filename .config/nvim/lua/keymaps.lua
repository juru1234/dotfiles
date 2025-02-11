local M = {}

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

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('v', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

vim.keymap.set("n", "<leader>f", require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>g", require('fzf-lua').live_grep, { desc = "Fzf Grep" })
vim.keymap.set("n", "<leader>b", require('fzf-lua').buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>a", require('fzf-lua').args, { desc = "Fzf Arguments" })
vim.keymap.set("n", "<leader>d", require('fzf-lua').diagnostics_document, { desc = "Fzf Diagnostics" })
vim.keymap.set("n", "<leader>r", require('fzf-lua').lsp_references, { desc = "Fzf References" })
vim.keymap.set("n", "<leader>c", require('fzf-lua').lsp_code_actions, { desc = "Fzf Code Actions" })

-- arglist
vim.keymap.set("n", "<Tab>", Cycle_arg_list)
vim.keymap.set("n", "<Leader>aa", ":ArgAdd<CR>")
vim.keymap.set('n', '<Leader>ap', ':lua vim.cmd("ArgAdd " .. vim.fn.input("position (1..n): "))<CR>')
vim.keymap.set("n", "<Leader>1", ":$argu 1<CR>")
vim.keymap.set("n", "<Leader>2", ":$argu 2<CR>")
vim.keymap.set("n", "<Leader>3", ":$argu 3<CR>")
vim.keymap.set("n", "<Leader>4", ":$argu 4<CR>")
vim.keymap.set("n", "<Leader>5", ":$argu 5<CR>")
vim.keymap.set("n", "<Leader>6", ":$argu 6<CR>")

-- undotree
vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })

vim.keymap.set('i', 'kj', "<Esc>")
vim.keymap.set('v', 'kj', "<Esc>")

-- automatically expand
vim.keymap.set('i', '(;', "(<CR>)<C-c>O<Tab>")
vim.keymap.set('i', '{;', "{<CR>}<C-c>O<Tab>")
vim.keymap.set('i', '[;', "[<CR>]<C-c>O<Tab>")
vim.keymap.set('i', '\'\'', "\'\'<Left>")
vim.keymap.set('i', '\"\"', "\"\"<Left>")
vim.keymap.set('i', '``', "``<Left>")

-- GitSigns Keymaps
M.gitsigns_keymaps = function(bufnr)
    local gitsigns = require('gitsigns')

    local function buf_map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Actions
    buf_map('n', 'hs', gitsigns.stage_hunk)
    buf_map('n', 'hsu', gitsigns.undo_stage_hunk)
    buf_map('n', 'hr', gitsigns.reset_hunk)
    buf_map('n', 'hv', gitsigns.preview_hunk)
    buf_map('n', 'hn', gitsigns.next_hunk)
    buf_map('n', 'hp', gitsigns.prev_hunk)

    buf_map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    buf_map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    buf_map('n', '<leader>hS', gitsigns.stage_buffer)
    buf_map('n', '<leader>hR', gitsigns.reset_buffer)

    buf_map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
    end)

    buf_map('n', '<leader>hd', gitsigns.diffthis)
    buf_map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
    buf_map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    buf_map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    buf_map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    buf_map('n', '<leader>td', gitsigns.toggle_deleted)
    buf_map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    buf_map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
end

return M
