-- Neotree
vim.keymap.set("", "<C-e>", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end)

vim.keymap.set("n", "<tab>", ":tabnext<Return>", opts)
vim.keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

vim.keymap.set("n", "<C-]>", vim.lsp.buf.code_action, bufopts)
vim.keymap.set("n", "<C-[>", vim.lsp.buf.format, bufopts)
