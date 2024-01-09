return {
	{
		"tpope/vim-fugitive",
		opts = {},
		config = function() end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function keymap(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- navigation
				keymap({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to next hunk" })

				keymap({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to previous hunk" })

				-- actions
				-- visual mode
				keymap("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage git hunk" })
				keymap("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
				-- normal mode
				keymap("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
				keymap("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
				keymap("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
				keymap("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
				keymap("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
				keymap("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
				keymap("n", "<leader>hb", function()
					gs.blame_line({ full = false })
				end, { desc = "git blame line" })
				keymap("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
				keymap("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "git diff against last commit" })

				-- toggles
				keymap("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
				keymap("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

				-- text object
				keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })

				vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
				vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
				vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
			end,
		},
	},
}
