-- Neotree
vim.keymap.set("", "<C-e>", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end)

-- Tab
-- vim.keymap.set("", "<tab>", ":tabnext<Return>", opts)
-- vim.keymap.set("", "<s-tab>", ":tabprev<Return>", opts)

-- LSP
vim.keymap.set("", "<C-]>", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("i", "<C-]>", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("", "<C-f>", vim.lsp.buf.format, bufopts)
vim.keymap.set("i", "<C-f>", vim.lsp.buf.format, bufopts)

-- Code edit
local doComment = function()
	local c = require("mini.comment")
	local _, from, _ = unpack(vim.fn.getpos('v'))
	local _, to, _ = unpack(vim.fn.getpos('.'))

	if from > to then
		local oldfrom = from
		from = to
		to = oldfrom
	end

	-- print(string.format("from : %d / to : %d", from, to))

	return c.toggle_lines(from, to, nil)
end
vim.keymap.set("", "<C-_>", doComment, { noremap = true, silent = true })
vim.keymap.set("i", "<C-_>", doComment, { noremap = true, silent = true })
