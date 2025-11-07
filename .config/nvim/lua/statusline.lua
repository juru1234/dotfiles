local function lsp_status()
	local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
	if #attached_clients == 0 then
		return ""
	end
	local it = vim.iter(attached_clients)
	it:map(function(client)
		local name = client.name:gsub("language.server", "ls")
		return name
	end)
	local names = it:totable()
	return "[" .. table.concat(names, ", ") .. "]"
end

local function file_status()
	local status = ""
	if vim.bo.readonly then
		status = status .. "[RO]"
	end
	if vim.bo.modifiable == false then
		status = status .. "[NM]"
	end
	if vim.bo.modified then
		status = status .. "[+]"
	end
	return status
end

local function git_branch()
	local branch = io.popen("git symbolic-ref --short HEAD 2>/dev/null || " .. "git rev-parse --short HEAD 2>/dev/null")
		:read("*a")
	return branch and branch:match("^%s*(.-)%s*$") or ""
end

-- Get the count of LSP warnings and errors
local function lsp_diagnostics()
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

	local diagnostic_str = ""

	if errors > 0 then
		diagnostic_str = diagnostic_str .. "E:" .. errors .. " "
	end
	if warnings > 0 then
		diagnostic_str = diagnostic_str .. "W:" .. warnings .. " "
	end

	return vim.fn.trim(diagnostic_str)
end

-- LSP indexing
local indexing_status = ""
local debounce_timer = nil
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client_id = ctx.client_id
	local client = vim.lsp.get_client_by_id(client_id)
	if not client then
		return
	end

	if result.value.kind == "begin" then
		indexing_status = "Indexing..."
		if debounce_timer then
			debounce_timer:stop()
		end
	elseif result.value.kind == "end" then
		indexing_status = ""
		debounce_timer = vim.defer_fn(function()
			vim.cmd("redrawstatus")
		end, 500)
	end
end

local function lsp_indexing()
	return indexing_status
end

local function file_type()
	return vim.bo.filetype ~= "" and vim.bo.filetype or "none"
end

function _G.statusline()
	local components = {
		"%f", -- File name
		file_status(), -- File status
		(lsp_diagnostics() ~= "" and "|" or ""),
		lsp_diagnostics(), -- LSP diagnostics
		(git_branch() ~= "" and "|" or ""),
		git_branch(), -- Git branch
		"%=", -- Align right
		lsp_status(), -- LSP clients
		(lsp_indexing() ~= "" and "|" or ""),
		lsp_indexing(), -- LSP indexing status
		(file_type() ~= "none" and "|" or ""),
		file_type(), -- File type
		" %-14(%l,%c%V%)", -- Line and column number
		"%P", -- Percentage through file
	}

	-- Filter out components that are empty strings
	local filtered_components = {}
	for _, component in ipairs(components) do
		if component and component ~= "" then
			table.insert(filtered_components, component)
		end
	end

	return table.concat(filtered_components, " ")
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"
