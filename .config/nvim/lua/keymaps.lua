vim.g.mapleader = ','

-- Disable arrow keys
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

-- Clear search highlighting with , and c
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
vim.keymap.set('n', '<leader>z', ':so %<CR>')

-- Fast saving with , and s
vim.keymap.set('n', '<leader>s', ':w<CR>')

-- Close all windows and exit from Neovim with , and q
vim.keymap.set('n', '<leader>q', ':qa!<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
vim.keymap.set('n', '<C-t>', ':Term<CR>', { noremap = true }) -- open
-- map escape to exit terminal mode (not good for lazygit)
-- vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
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
        vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
            end, { desc = "Format Buffer" })

        --vim.keymap.set('n', '<space>f', conform.format())
        vim.keymap.set('v', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- fzf-lua
vim.keymap.set('n', '<leader>f', require('fzf-lua').files, { desc = 'Fzf Files' })
vim.keymap.set('n', '<leader>g', require('fzf-lua').live_grep, { desc = 'Fzf Grep' })
vim.keymap.set('n', '<leader>b', require('fzf-lua').buffers, { desc = 'Fzf Buffers' })
vim.keymap.set('n', '<leader>a', require('fzf-lua').args, { desc = 'Fzf Arguments' })
vim.keymap.set('n', '<leader>d', require('fzf-lua').diagnostics_document, { desc = 'Fzf Diagnostics' })
vim.keymap.set('n', '<leader>r', require('fzf-lua').lsp_references, { desc = 'Fzf References' })
vim.keymap.set('n', '<leader>c', require('fzf-lua').lsp_code_actions, { desc = 'Fzf Code Actions' })

-- arglist
vim.keymap.set('n', '<Tab>', Cycle_arg_list)
vim.keymap.set('n', '<leader>aa', ':ArgAdd<CR>')
vim.keymap.set('n', '<leader>ap', ':lua vim.cmd("ArgAdd " .. vim.fn.input("position (1..n): "))<CR>')
vim.keymap.set('n', '<leader>1', ':$argu 1<CR>')
vim.keymap.set('n', '<leader>2', ':$argu 2<CR>')
vim.keymap.set('n', '<leader>3', ':$argu 3<CR>')
vim.keymap.set('n', '<leader>4', ':$argu 4<CR>')
vim.keymap.set('n', '<leader>5', ':$argu 5<CR>')
vim.keymap.set('n', '<leader>6', ':$argu 6<CR>')

-- hack for normal keybaords
vim.keymap.set('i', 'kj', '<Esc>l')
vim.keymap.set('v', 'kj', '<Esc>')

-- automatically expand
vim.keymap.set('i', '(;', '(<CR>)<C-c>O<Tab>')
vim.keymap.set('i', '{;', '{<CR>}<C-c>O<Tab>')
vim.keymap.set('i', '[;', '[<CR>]<C-c>O<Tab>')
vim.keymap.set('i', '\'\'', '\'\'<Left>')
vim.keymap.set('i', '\'\'', '\'\'<Left>')
vim.keymap.set('i', '``', '``<Left>')

-- lazygit
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>')

-- leap (Bidirectional s for Normal and Visual mode)
vim.keymap.set({ 'n', 'x' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
vim.keymap.set('o', 's', '<Plug>(leap-forward)')
vim.keymap.set('o', 'S', '<Plug>(leap-backward)')
