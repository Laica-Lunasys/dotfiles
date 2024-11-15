-- return {
-- 	{
-- 		"tomasr/molokai",
-- 		lazy = true,
-- 		priority = 1000,
-- 		opts = function()
-- 			vim.cmd([[
--             augroup TransparentColours
--             autocmd!
--             autocmd ColorScheme * highlight normal ctermbg=NONE guiBG=NONE
--             augroup end
--             ]])
--
-- 			return {
-- 				transparent = true,
-- 			}
-- 		end,
-- 	},
-- }

return {
	{
		--"tanvirtin/monokai.nvim",
		"UtkarshVerma/molokai.nvim",
		opts = function()
			-- vim.cmd([[
			--     augroup TransparentColours
			--     autocmd!
			--     autocmd ColorScheme * highlight normal ctermbg=NONE guiBG=NONE
			--     augroup end
			-- ]])
			return {
				style = "night",
				transparent = true,
				styles = {
					sidebars = "transparent",
					-- floats = "transparent",
				},
			}
		end,
	},
}
