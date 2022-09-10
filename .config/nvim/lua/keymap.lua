-- Completion
-- vim.keymap.set('i', '<Tab>', '<C-N>')
-- vim.keymap.set('i', '<S-Tab>', '<C-P>')
vim.cmd [[
    inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]]

-- Select all
vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
vim.keymap.set('n', 'st', ':tabedit<CR>')

-- Split window
vim.keymap.set('n', 's-', ':split<Return><C-w>w')
vim.keymap.set('n', 's|', ':vsplit<Return><C-w>w')

-- Move window
vim.keymap.set('n', '<Space>', '<C-w>w')
vim.keymap.set('', 'sh', '<C-w>h')
vim.keymap.set('', 'sk', '<C-w>k')
vim.keymap.set('', 'sj', '<C-w>j')
vim.keymap.set('', 'sl', '<C-w>l')
