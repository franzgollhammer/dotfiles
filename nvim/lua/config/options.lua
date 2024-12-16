local opt = vim.opt

-- tab / indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = false
-- Enable break indent
vim.opt.breakindent = true

-- Decrease update time
opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- opt.timeoutlen = 300

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- search
opt.incsearch = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "80,120"

-- Keep signcolumn on by default
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 5
-- opt.completeopt = "menuone,noinsert,noselect"

opt.cursorline = true
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '↲' }

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Save undo history
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.clipboard:append("unnamedplus")

-- Folding
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99


