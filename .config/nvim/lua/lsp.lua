local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  clangd = {
    cmd = { "clangd" },
    capabilities = capabilities,
  },
  rust_analyzer = {
    cmd = { "rust-analyzer" },
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        check = { command = "clippy" },
      },
    },
  },
  pyright = {
    cmd = { "pyright" },
    capabilities = capabilities,
  },
  tsserver = {
    cmd = { "tsserver" },
    capabilities = capabilities,
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    capabilities = capabilities,
  },
  bashls = {
    cmd = { "bash-language-server" },
    capabilities = capabilities,
    filetypes = { "sh", "bash", "zsh" },
  },
  gopls = {
    cmd = { "gopls" },
    capabilities = capabilities,
  },
}

for name, config in pairs(servers) do
  if Is_executable_in_path(config.cmd[1]) then
    vim.lsp.config[name] = config
    vim.lsp.enable(name)
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
