return {
  "nvim-lualine/lualine.nvim",
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- set bg to none for transparent background
    -- local custom_auto = require("lualine.themes.auto")
    -- custom_auto.normal.c.bg = "NONE"

    require("lualine").setup({
      options = {
        -- theme = custom_auto,
        theme = "auto",
        icons_enabled = false,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = { { "filename", file_status = true, path = 1 }, "aerial" },
        lualine_x = { "encoding", "filetype" },
      },
    })
  end,
}
