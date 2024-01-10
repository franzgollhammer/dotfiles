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
require("config.autocmds")

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

-- set colorscheme
vim.cmd([[colorscheme gruvbox-material]])
-- vim.cmd([[colorscheme rose-pine]])

-- Transparent background for float
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }):verbose :hi SignColumn
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
