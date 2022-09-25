require('plugins')
require('keymap')
require('file')

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.number = true
vim.opt.mouse = "a"

-- Theme
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5

-- Clipboard
vim.opt.clipboard = "unnamedplus"
vim.cmd [[
    if has('clipboard') || exists('g:vscode')
        set clipboard^=unnamed

        if has('nvim') && exists('$WSLENV')
            let g:clipboard = {
            \     'name': 'xclip-wsl',
            \     'copy': {
            \         '+': 'xclip -i',
            \         '*': 'xclip -i',
            \     },
            \     'paste': {
            \         '+': 'xclip -o',
            \         '*': 'xclip -o',
            \     },
            \    'cache_enabled': 0,
            \ }
        endif
    endif
]]

-- Editor options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true

-- Expand status area
vim.opt.laststatus = 2
vim.opt.backspace = { 'start', 'eol', 'indent' }

vim.opt.ttimeoutlen = 10

-- Auto reload
vim.bo.autoread = true
vim.cmd [[
    au CursorHold * checktime
    au CursorHold,CursorHoldI * checktime
    au FocusGained,BufEnter * checktime
    augroup vimrc-checktime
      autocmd!
      autocmd WinEnter * checktime
    augroup END
]]

-- Enable search highlight
vim.opt.hlsearch = true
vim.opt.incsearch = true
