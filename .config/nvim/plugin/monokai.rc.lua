local status, monokai = pcall(require, "monokai")
if (not status) then return end

local palette = monokai.pro

monokai.setup({
    italics = false,
    custom_hlgroups = {
        TSInclude = {
            fg = palette.aqua,
        },
        GitSignsAdd = {
            fg = palette.green,
            bg = palette.base2
        },
        GitSignsDelete = {
            fg = palette.pink,
            bg = palette.base2
        },
        GitSignsChange = {
            fg = palette.orange,
            bg = palette.base2
        },
    }
})

vim.highlight.create('Normal', { ctermbg = 'none', guibg = 'none' })
vim.highlight.create('NonText', { ctermbg = 'none', guibg = 'none' })
