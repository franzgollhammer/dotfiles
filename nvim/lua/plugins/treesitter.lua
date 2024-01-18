return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"python",
				"go",
				"rust",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"vue",
				"javascript",
				"typescript",
				"json",
				"css",
				"scss",
				"html",
			},
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = true,
				disable = {},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						scope_incremental = "<CR>",
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
			},
		})
	end,
}
