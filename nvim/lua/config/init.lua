local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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

-- colors
vim.cmd([[colorscheme gruvbox]])
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#504944" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#504944" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#504944" })
