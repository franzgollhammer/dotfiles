return {
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<C-g>", "<Cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          -- add = { text = "+" },
          -- change = { text = "~" },
          -- delete = { text = "_" },
          -- topdelete = { text = "‾" },
          -- changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- activate line blame
          gs.toggle_current_line_blame()

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
          keymap("v", "<Leader>Hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "stage git hunk" })
          keymap("v", "<Leader>Hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "reset git hunk" })
          -- normal mode
          keymap("n", "<Leader>Hs", gs.stage_hunk, { desc = "git stage hunk" })
          keymap("n", "<Leader>Hr", gs.reset_hunk, { desc = "git reset hunk" })
          keymap("n", "<Leader>HS", gs.stage_buffer, { desc = "git Stage buffer" })
          keymap("n", "<Leader>Hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
          keymap("n", "<Leader>HR", gs.reset_buffer, { desc = "git Reset buffer" })
          keymap("n", "<Leader>Hp", gs.preview_hunk, { desc = "preview git hunk" })
          keymap("n", "<Leader>Hb", function()
            gs.blame_line({ full = false })
          end, { desc = "git blame line" })
          keymap("n", "<Leader>Hd", gs.diffthis, { desc = "git diff against index" })
          keymap("n", "<Leader>HD", function()
            gs.diffthis("~")
          end, { desc = "git diff against last commit" })

          -- toggles
          keymap("n", "<Leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
          keymap("n", "<Leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

          -- text object
          keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })

          -- vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
          -- vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
          -- vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
        end,
      })
    end
  }
}
