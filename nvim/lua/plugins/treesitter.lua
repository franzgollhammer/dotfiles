return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"vue",
				"javascript",
				"typescript",
				"css",
				"scss",
				"html",
			},
			auto_install = true,
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = true,
				disable = {},
			},
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
        colors = {
          "#ffff00",
          "#00ff00",
          "#00ffff",
          "#0000ff",
          "#ff00ff",
        },
      },
		})
	end,
}