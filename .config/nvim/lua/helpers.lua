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
