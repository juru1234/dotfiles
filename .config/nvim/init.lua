if vim.fn.has("nvim-0.10") == 0 then
    vim.notify("This config only supports Neovim 0.10+", vim.log.levels.ERROR)
    return
end

require('helpers')
require('plugins')
require('keymaps')
-- require('statusline')
require('lsp')
require('options')

vim.cmd.colorscheme "catppuccin-mocha"

-- Use osc52 as clipboard provider
local function paste()
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
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

-- Show the status of the LSP bottom right
require "fidget".setup()
-- file explorer
require("oil").setup()
-- statusline
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
    },
    sections = {
        lualine_c = { { 'filename', path = 1 } },
    },
}

-- fast motions
require('leap').setup({})

-- vimtex
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_compiler_latexmk = {
    build_dir = '',         -- Specify the build directory if needed
    callback = 1,           -- Enable the callback function
    continuous = 1,         -- Disable continuous mode (for single builds)
    executable = 'latexmk', -- Use 'make' as the build command
    options = {},           -- Additional options (leave empty for default)
}

-- lazygit
vim.g.lazygit_floating_window_scaling_factor = 0.95

-- hardtime
vim.cmd("let g:hardtime_timeout = 300")
vim.cmd("let g:hardtime_default_on = 1")

-- abbreviations
vim.cmd(':autocmd FileType c :iabbrev <buffer> pr@ pr_info("%s:\\n", __func__);<Esc>F\\i')
vim.cmd('iabbrev sn@ -- snip --<Esc>F\\i')
vim.cmd('iabbrev thx@ Thanks,<CR>Julian<Esc>F\\i')

-- Set Terminal automatically to insert mode
-- and hide line numbers in terminal mode
vim.cmd('autocmd BufEnter,BufNew term://* startinsert')
vim.cmd('autocmd BufEnter,BufNew term://* set laststatus=0')
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber nobuflisted')

-- system-specific config
local sys_specific_config = vim.fn.stdpath("config") .. "/lua/systemspecific.lua"
if vim.fn.filereadable(sys_specific_config) == 1 then
  dofile(sys_specific_config)
end
