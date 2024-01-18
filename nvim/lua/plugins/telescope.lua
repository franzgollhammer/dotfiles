return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local keymap = vim.keymap.set
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
						n = {
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
					},
				},
			})

			local function telescope_live_grep_open_files()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end

			keymap("n", "<leader>k", builtin.oldfiles, { desc = "[k] Find recently opened files" })
			keymap("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
			keymap(
				"n",
				"<leader>/",
				builtin.current_buffer_fuzzy_find,
				{ desc = "[/] Fuzzily search in current buffer" }
			)
			keymap("n", "<leader>f/", telescope_live_grep_open_files, { desc = "[F]ind [/] in Open Files" })
			keymap("n", "<leader>gf", builtin.git_files, { desc = "[F]ind [G]it Files" })
			keymap("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			keymap("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
			keymap("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
			keymap("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			keymap("n", "<leader>fG", ":LiveGrepGitRoot<cr>", { desc = "[F]ind by [G]rep on Git Root" })
			keymap("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		end,
	},
}
