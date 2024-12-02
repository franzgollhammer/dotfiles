return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
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
    }
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      transparent = true
    }
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      transparent = true
    }
  },
  {
    "rose-pine/neovim",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
    end
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      transparent = true
    }
  },
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    opts = {
      transparent_background = true
    }
  }
}
