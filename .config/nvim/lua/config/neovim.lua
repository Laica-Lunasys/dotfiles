vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.number = true
vim.opt.mouse = "a"

-- indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true

-- Enable search highlight
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Expand status area
vim.opt.laststatus = 2
vim.opt.backspace = { "start", "eol", "indent" }

-- Auto reload
vim.bo.autoread = true

-- Disable autoformat
vim.b.autoformat = false
vim.g.autoformat = false

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Disabled for WSL2 (wslg)
-- vim.cmd([[
--     if has('clipboard') || exists('g:vscode')
--         set clipboard^=unnamedplus
-- 
--         if has('nvim') && exists('$WSLENV')
--             let g:clipboard = {
--             \     'name': 'xclip-wsl',
--             \     'copy': {
--             \         '+': 'xclip -i',
--             \         '*': 'xclip -i',
--             \     },
--             \     'paste': {
--             \         '+': 'xclip -o',
--             \         '*': 'xclip -o',
--             \     },
--             \    'cache_enabled': 0,
--             \ }
--         endif
--     endif
-- ]])
