return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local custom_auto = require("lualine.themes.auto")
    custom_auto.normal.c.bg = "NONE"

		require("lualine").setup({
			options = {
				theme = custom_auto,
			},
		})
	end,
}
