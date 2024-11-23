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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = false }),
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end
})
