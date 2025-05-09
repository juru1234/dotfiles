-- Source: https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc

local M = {}

M.setup = function(ev)
    local function keymap(lhs, rhs, opts, mode)
        opts = type(opts) == 'string' and { desc = opts }
            or vim.tbl_extend('error', opts --[[@as table]], { buffer = bufnr })
        mode = mode or 'n'
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    ---For replacing certain <C-x>... keymaps.
    ---@param keys string
    local function feedkeys(keys)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
    end

    ---Is the completion menu open?
    local function pumvisible()
        return tonumber(vim.fn.pumvisible()) ~= 0
    end

    -- Enable completion and configure keybindings.
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })

    -- Use enter to accept completions.
    keymap('<cr>', function()
        return pumvisible() and '<C-y>' or '<cr>'
    end, { expr = true }, 'i')

    -- Use slash to dismiss the completion menu.
    keymap('/', function()
        return pumvisible() and '<C-e>' or '/'
    end, { expr = true }, 'i')

    -- Use <C-n> to navigate to the next completion or:
    -- - Trigger LSP completion.
    -- - If there's no one, fallback to vanilla omnifunc.
    keymap('<C-n>', function()
        if pumvisible() then
            feedkeys '<C-n>'
        else
            if next(vim.lsp.get_clients { bufnr = 0 }) then
                vim.lsp.completion.trigger()
            else
                if vim.bo.omnifunc == '' then
                    feedkeys '<C-x><C-n>'
                else
                    feedkeys '<C-x><C-o>'
                end
            end
        end
    end, 'Trigger/select next completion', 'i')
end

return M
