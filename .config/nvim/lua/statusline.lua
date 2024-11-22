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
    local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("%s+", "") == "true"
    if not is_git_repo then
        return ""
    end

    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    return vim.fn.trim(branch)
end

-- Function to get the count of LSP warnings and errors
local function lsp_diagnostics()
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

    local diagnostic_str = ""

    if errors > 0 then
        diagnostic_str = diagnostic_str .. "E" .. errors .. " " -- Red for errors
    end
    if warnings > 0 then
        diagnostic_str = diagnostic_str .. "W" .. warnings .. " " -- Yellow for warnings
    end

    return vim.fn.trim(diagnostic_str)
end

function _G.statusline()
    return table.concat({
        "%f",                -- File name
        "%h%w%m%r",          -- File status
        lsp_diagnostics() ~= "" and "|" or "",
        lsp_diagnostics(),   -- LSP Errors/Warnings
        git_branch() ~= "" and "|" or "",
        git_branch(),        -- Git branch
        "%=",                -- Align right
        lsp_status(),        -- LSP clients
        " %-14(%l,%c%V%)",    -- Line and column number
        "%P",                -- Percentage through file
    }, " ")
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"
