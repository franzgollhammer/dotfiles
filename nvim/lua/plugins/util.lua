return {
  {
    "nvim-tree/nvim-web-devicons"
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        event = "InsertEnter",
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
        }
      }
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
    config = function()
      require("colorizer").setup({
        '*',
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<Leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  },
}
