return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				overrides = {
					TelescopeBorder = { bg = "none", fg = "none" },
					SignColumn = { bg = "none" },
					GruvboxRedSign = { bg = "none" },
					GruvboxYellowSign = { bg = "none" },
					GruvboxBlueSign = { bg = "none" },
					GruvboxAquaSign = { bg = "none" },
				},
			})
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
	},
}
