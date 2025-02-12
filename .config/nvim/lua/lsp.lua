local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

-- name: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- executable: name of the language server executable in $PATH
local servers = {
	{ name = 'clangd',        executable = 'clangd' },
	{ name = 'rust_analyzer', executable = 'rust-analyzer' },
	{ name = 'pyright',       executable = 'pyright' },
	{ name = 'tsserver',      executable = 'tsserver' },
	{ name = 'lua_ls',        executable = 'lua-language-server' },
	{ name = 'bashls',        executable = 'bash-language-server' },
	{ name = 'gopls',         executable = 'gopls' }
}

-- only set up LSP if it exists in $PATH
for _, server in ipairs(servers) do
	if Is_executable_in_path(server.executable) then
		if server.name == "rust_analyzer" then
			lspconfig[server.name].setup {
				capabilities = capabilities,
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
				capabilities = capabilities,
				filetypes = { "sh", "bash", "zsh" },
			}
		else
			lspconfig[server.name].setup {
				capabilities = capabilities,
			}
		end
	end
end

-- nvim-cmp: completion engine plugin for neovim
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
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
			else
				fallback()
			end
		end, { 'i', 's' }),
		-- Shift + Tab
		["S-TAB"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
	},
}
