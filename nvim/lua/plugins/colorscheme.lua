return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function() end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
      })
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
  }
}
