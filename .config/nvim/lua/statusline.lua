local function lsp_status()
    local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #attached_clients == 0 then
        return ""
    end
    local it = vim.iter(attached_clients)
    it:map(function (client)
        local name = client.name:gsub("language.server", "ls")
        return name
    end)
    local names = it:totable()
    return "[" .. table.concat(names, ", ") .. "]"
end

local function git_branch()
    -- Using 'git rev-parse --abbrev-ref HEAD' to get the current branch name
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    return vim.fn.trim(branch) -- trim any extra whitespace
end

function _G.statusline()
    return table.concat({
        "%f",                -- File name
        "%h%w%m%r",          -- File status
        git_branch(),        -- Git branch
        "%=",                -- Align right
        lsp_status(),        -- LSP clients
        " %-14(%l,%c%V%)",    -- Line and column number
        "%P",                -- Percentage through file
    }, " ")
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"
