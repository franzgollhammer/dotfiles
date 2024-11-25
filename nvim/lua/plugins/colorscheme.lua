return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        dim_inactive = false,
        transparent_mode = true,
        -- overrides = {
        --   TelescopeBorder = { bg = "none", fg = "none" },
          -- SignColumn = { bg = "none" },
        --   GruvboxRedSign = { bg = "none" },
        --   GruvboxYellowSign = { bg = "none" },
        --   GruvboxBlueSign = { bg = "none" },
        --   GruvboxAquaSign = { bg = "none" },
        -- },
      })
    end
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000
  },
  {
    "tjdevries/colorbuddy.nvim",
    priority = 1000
  },
  {
    "Mofiqul/dracula.nvim",
    priority = 1000
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000
  }
}
