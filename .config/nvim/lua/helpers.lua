function Is_executable_in_path(executable)
	return vim.fn.executable(executable) == 1
end

-- helper to cycle through the argument list
function Cycle_arg_list()
	if vim.fn.argc() <= 1 then
		print("Nothing to cycle")
		return
	end
	local success, _ = pcall(vim.cmd, 'next')
	if not success then
		vim.cmd('first')
	end
end

-- helper to add current buffer to argument list
vim.api.nvim_create_user_command(
	'ArgAdd',
	function(opts)
		if opts.args == "" then
			vim.cmd('$argadd')
			vim.cmd('argdedupe')
			return
		end
		local arg_num = tonumber(opts.args)
		if arg_num < 1 then
			print("Argument must be 1..n")
			return
		end
		vim.cmd(opts.args - 1 .. 'argadd')
		vim.cmd('argdedupe')
	end,
	{ nargs = '?' }
)

-- helper to use nvim for composing mails
vim.api.nvim_create_user_command("EditMail", function(args)
	-- Get the current buffer and its lines
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

	-- Create a new buffer that allows editing
	local b = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(b, 0, -1, false, lines)
	vim.api.nvim_win_set_buf(0, b)
	vim.cmd('setlocal modifiable')

	-- Handle >
	vim.api.nvim_set_hl(0, 'quotedDeletion', { fg = 'red' })
	vim.api.nvim_set_hl(0, 'quotedAddition', { fg = 'green' })
	vim.api.nvim_set_hl(0, 'quote', { fg = 'white' })

	vim.api.nvim_command('syntax match quote "^>* "')
	vim.api.nvim_command('syntax match quotedDeletion "^>* *-.*" contains=quote')
	vim.api.nvim_command('syntax match quotedAddition "^>* *+.*" contains=quote')
end, {})
