local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.globals")
require("config.options")
require("config.keymaps")
require("config.commands")

local plugins = "plugins"
local opts = {
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
     disabled_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
      },
    },
  },
}

require("lazy").setup(plugins, opts)

require("vscode2026").setup({
  transparent = true,
})
vim.cmd([[colorscheme dark2026]])
-- vim.cmd([[colorscheme light2026]])
-- vim.cmd([[colorscheme tokyonight]])
-- vim.cmd([[colorscheme rose-pine]])

