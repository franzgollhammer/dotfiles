return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        -- transparent_mode = true,
        contrast = "hard",
        overrides = {
          -- 	TelescopeBorder = { bg = "none", fg = "none" },
          -- SignColumn = { bg = "none" },
          -- GruvboxRedSign = { bg = "none" },
          -- GruvboxYellowSign = { bg = "none" },
          -- GruvboxBlueSign = { bg = "none" },
          -- GruvboxAquaSign = { bg = "none" },
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
  },
}
