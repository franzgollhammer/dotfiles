return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
        -- contrast = "hard",
        overrides = {
          -- 	TelescopeBorder = { bg = "none", fg = "none" },
          SignColumn = { bg = "none" },
          GruvboxRedSign = { bg = "none" },
          GruvboxYellowSign = { bg = "none" },
          GruvboxBlueSign = { bg = "none" },
          GruvboxAquaSign = { bg = "none" },
        },
      })
    end,
  },
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        }
      })
    end,
  },
}
