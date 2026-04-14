return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {},
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "python",
        "go",
        "gomod",
        "rust",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "vue",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "css",
        "scss",
        "html",
        "bash",
        "markdown",
        "markdown_inline",
        "toml",
        "yaml",
        "dockerfile",
      },
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
        disable = {},
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<s-CR>",
          scope_incremental = "<CR>",
          node_incremental = "<s-n>",
          node_decremental = "<s-m>",
        },
      },
    })
  end,
}
