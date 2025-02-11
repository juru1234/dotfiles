local M = {}

vim.g.mapleader = ','

-- Disable arrow keys
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

-- Clear search highlighting with <leader> and c
vim.keymap.set('n', '<leader>c', ':nohl<CR>')

-- Toggle auto-indenting for code paste
vim.keymap.set('n', '<F2>', ':set invpaste paste?<CR>')

-- Change split orientation
vim.keymap.set('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', '<C-left>', '<C-w>h')
vim.keymap.set('n', '<C-down>', '<C-w>j')
vim.keymap.set('n', '<C-up>', '<C-w>k')
vim.keymap.set('n', '<C-right>', '<C-w>l')

-- Reload configuration without restart nvim
vim.keymap.set('n', '<leader>r', ':so %<CR>')

-- Fast saving with <leader> and s
vim.keymap.set('n', '<leader>s', ':w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
vim.keymap.set('n', '<leader>q', ':qa!<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
vim.keymap.set('n', '<C-t>', ':Term<CR>', { noremap = true }) -- open
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')                   -- exit
vim.keymap.set('t', '<C-left>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-down>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-up>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-right>', '<C-\\><C-n><C-w>l')

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', 'vim.diagnostic.open_float')
vim.keymap.set('n', '[d', 'vim.diagnostic.goto_prev')
vim.keymap.set('n', ']d', 'vim.diagnostic.goto_next')
vim.keymap.set('n', '<space>q', 'vim.diagnostic.setloclist')

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

-- fzf-lua
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

-- hack for normal keybaords
vim.keymap.set('i', 'kj', "<Esc>")
vim.keymap.set('v', 'kj', "<Esc>")

-- automatically expand
vim.keymap.set('i', '(;', "(<CR>)<C-c>O<Tab>")
vim.keymap.set('i', '{;', "{<CR>}<C-c>O<Tab>")
vim.keymap.set('i', '[;', "[<CR>]<C-c>O<Tab>")
vim.keymap.set('i', '\'\'', "\'\'<Left>")
vim.keymap.set('i', '\"\"', "\"\"<Left>")
vim.keymap.set('i', '``', "``<Left>")

-- gitsigns
M.gitsigns_keymaps = function(bufnr)
    local gitsigns = require('gitsigns')

    -- Actions
    vim.keymap.set('n', 'hs', gitsigns.stage_hunk)
    vim.keymap.set('n', 'hsu', gitsigns.undo_stage_hunk)
    vim.keymap.set('n', 'hr', gitsigns.reset_hunk)
    vim.keymap.set('n', 'hv', gitsigns.preview_hunk)
    vim.keymap.set('n', 'hn', gitsigns.next_hunk)
    vim.keymap.set('n', 'hp', gitsigns.prev_hunk)

    vim.keymap.set('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    vim.keymap.set('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer)
    vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer)

    vim.keymap.set('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
    end)

    vim.keymap.set('n', '<leader>hd', gitsigns.diffthis)
    vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end)
    vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    vim.keymap.set('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted)
    vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
end

return M
