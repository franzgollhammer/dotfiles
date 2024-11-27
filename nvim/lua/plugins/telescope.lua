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
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
            n = {
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true
          },
          git_files = {
            hidden = true
          }
        },
        extensions = {
          aerial = {
            -- Set the width of the first two columns (the second
            -- is relevant only when show_columns is set to 'both')
            col1_width = 4,
            col2_width = 30,
            -- How to format the symbols
            format_symbol = function(symbol_path, filetype)
              if filetype == "json" or filetype == "yaml" then
                return table.concat(symbol_path, ".")
              else
                return symbol_path[#symbol_path]
              end
            end,
            -- Available modes: symbols, lines, both
            show_columns = "both",
          },
        },
      })

      -- Load extensions for autocomplete
      require("telescope").load_extension("aerial")

      local function telescope_live_grep_open_files()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end

      local function most_recent_files()
        builtin.buffers({
          sort_mru = true,
        })
      end

      keymap("n", "<Leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
      keymap("n", "<Leader><space>", builtin.oldfiles, { desc = "[Space] Find recently opened files" })
      keymap("n", "<Leader>sb", most_recent_files, { desc = "[S]earch existing [B]uffers" })
      keymap(
        "n",
        "<Leader>/",
        builtin.current_buffer_fuzzy_find,
        { desc = "[/] Fuzzily search in current buffer" }
      )
      keymap("n", "<Leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
      keymap("n", "<Leader>sf", builtin.git_files, { desc = "Search [G]it [F]iles" })
      keymap("n", "<Leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
      keymap("n", "<Leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      keymap("n", "<Leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      keymap("n", "<Leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      keymap("n", "<Leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

      -- Extensions
      -- Aerial symbol search
      keymap("n", "<Leader>ss", "<Cmd>Telescope aerial<CR>", { desc = "[S]earch [S]ymbols" })
    end,
  },
}
