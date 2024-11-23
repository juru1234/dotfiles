local lspconfig = require('lspconfig')

-- name: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- executable: name of the language server executable in $PATH
local servers = {
    { name = 'clangd',        executable = 'clangd' },
    { name = 'rust_analyzer', executable = 'rust-analyzer' },
    { name = 'pyright',       executable = 'pyright' },
    { name = 'tsserver',      executable = 'tsserver' },
    { name = 'lua_ls',        executable = 'lua-language-server' },
    { name = 'bashls',        executable = 'bash-language-server' }
}

-- only set up LSP if it exists in $PATH
for _, server in ipairs(servers) do
    if Is_executable_in_path(server.executable) then
        if server.name == "rust_analyzer" then
            lspconfig[server.name].setup {
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                        },
                    },
                },
            }
        elseif server.name == "bashls" then
            lspconfig[server.name].setup {
                filetypes = { "sh", "bash", "zsh" },
            }
        else
            lspconfig[server.name].setup {
            }
        end
    end
end

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

        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = false })
        vim.keymap.set('i', '<C-space>', vim.lsp.completion.trigger, opts)
    end,
})
