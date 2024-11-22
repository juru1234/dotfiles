if vim.fn.has("nvim-0.10") == 0 then
    vim.notify("This config only supports Neovim 0.10+", vim.log.levels.ERROR)
    return
end

require('helpers')
require('plugins')
require('keymaps')
require('statusline')
require('lsp')
require('options')

-- Use the gruvbox color scheme
vim.cmd("let g:gruvbox_transparent_bg = 1")
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")
vim.cmd('colorscheme gruvbox')

-- Use osc52 as clipboard provider
local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
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
-- To ALWAYS use the clipboard for ALL operations
-- (instead of interacting with the "+" and/or "*" registers explicitly):
vim.opt.clipboard = "unnamedplus"

-- file explorer
require("oil").setup()

-- fast motions
require('leap').create_default_mappings()
vim.keymap.set('n', 's', function()
	require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)

-- vimtex
vim.g.vimtex_view_general_viewer='okular'
vim.g.vimtex_compiler_latexmk = {
  build_dir = '', -- Specify the build directory if needed
  callback = 1, -- Enable the callback function
  continuous = 1, -- Disable continuous mode (for single builds)
  executable = 'latexmk', -- Use 'make' as the build command
  options = {}, -- Additional options (leave empty for default)
}

-- hardtime
vim.cmd("let g:hardtime_timeout = 300")
vim.cmd("let g:hardtime_default_on = 1")

-- abbreviations
vim.cmd(':autocmd FileType c :iabbrev <buffer> pr@ pr_info("%s:\\n", __func__);<Esc>F\\i')

-- Set Terminal automatically to insert mode
-- and hide line numbers in terminal mode
vim.cmd('autocmd BufEnter,BufNew term://* startinsert')
vim.cmd('autocmd BufEnter,BufNew term://* set laststatus=0')
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber nobuflisted')
