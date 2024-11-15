return {
	{
		"loctvl842/monokai-pro.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			vim.cmd([[
            augroup TransparentColours
            autocmd!
            autocmd ColorScheme * highlight normal ctermbg=NONE guiBG=NONE
            augroup end
            ]])

			return {
				transparent_background = true,
				terminal_colors = true,
				devicons = true, -- highlight the icons of `nvim-web-devicons`
				filter = "classic", -- classic | octagon | pro | machine | ristretto | spectrum
				inc_search = "background", -- underline | background
				background_clear = {
					-- "float_win",
					"toggleterm",
					"telescope",
					"which-key",
					"renamer",
					"notify",
					"nvim-tree",
					--"neo-tree",
					--"bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
				}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
				plugins = {
					bufferline = {
						underline_selected = false,
						underline_visible = false,
					},
					indent_blankline = {
						context_highlight = "default", -- default | pro
						context_start_underline = false,
					},
				},
			}
		end,
	},
}
