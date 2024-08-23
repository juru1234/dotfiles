local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'bashls' }
local servers_in_path = { 'clangd', 'rust-analyzer', 'pyright', 'tsserver', 'lua-language-server',
	'bash-language-server' }

-- only setup LSP if it is in PATH
for index, lsp in ipairs(servers_in_path) do
	if Is_executable_in_path(lsp) then
		if lsp == "rust-analyzer" then
			lspconfig[servers[index]].setup {
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			}
		elseif lsp == "bash-language-server" then
			lspconfig[servers[index]].setup {
				capabilities = capabilities,
				filetypes = { "sh", "bash", "zsh" },
			}
		else
			lspconfig[servers[index]].setup {
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
