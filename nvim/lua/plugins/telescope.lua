return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
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

      keymap("n", "<leader>pp", builtin.oldfiles, { desc = "[p] Find recently opened files" })
      keymap("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      keymap(
        "n",
        "<leader>/",
        builtin.current_buffer_fuzzy_find,
        { desc = "[/] Fuzzily search in current buffer" }
      )
      keymap("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
      keymap("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
      keymap("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      keymap("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      keymap("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      keymap("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      keymap("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
      keymap("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    end,
  },
}
