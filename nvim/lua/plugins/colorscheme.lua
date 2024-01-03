return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priotity = 1000,
    opts = {
    },
    config = function()
      require("catppuccin").setup({
        term_colors = true,
        transparent_background = false,
        styles = {
          comments = {},
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
      })

      -- vim.cmd.colorscheme("catppuccin")
    end

  },
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        disable_background = true,
      })
      vim.cmd.colorscheme("rose-pine")
    end
  }

}
