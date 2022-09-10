local status, lualine = pcall(require, "lualine")

if (not status) then return end

lualine.setup {
    options = {
        icons_enabled = false,

        -- Themes can be found from here:
        -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
        theme = 'ayu_dark',
        -- theme = 'powerline',

        -- Default separators:
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            {
                'filename',
                file_status = true,
                path = 0
            }
        },
        lualine_c = {},
        lualine_x = { 'diff', 'diagnostics', 'branch', 'fileformat', 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1
            }
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {
            {
                'tabs',
                mode = 2,
                tabs_color = {
                    active = 'lualine_a_normal',
                },
            }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            'tabs'
        }
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
