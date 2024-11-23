function vim.snippet.add(trigger, body, opts)
    vim.keymap.set("ia", trigger, function()
        -- If abbrev is expanded with keys like "(", ")", "<cr>", "<space>",
        -- don't expand the snippet. Only accept "<c-]>" as trigger key.
        local c = vim.fn.nr2char(vim.fn.getchar(0))
        if c ~= "" then
            vim.api.nvim_feedkeys(trigger .. c, "i", true)
            return
        end
        vim.snippet.expand(body)
    end, opts)
end


vim.snippet.add(
    "fn",
    "function ${1:name}($2)\n\t${3:-- content}\nend",
    { buffer = 0 }
)
vim.snippet.add(
    "lfn",
    "local function ${1:name}($2)\n\t${3:-- content}\nend",
    { buffer = 0 }
)
