local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Follow the leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

keymap("n", "<leader>Q", ":q<cr>", opts)
keymap("n", "<leader>W", ":w<cr>", opts)
-- keymap("n", "<leader><leader>q", ":bd<cr>", opts)

-- Navigation
keymap("n", "<leader>hh", "<C-w>h", opts)
keymap("n", "<leader>jj", "<C-w>j", opts)
keymap("n", "<leader>kk", "<C-w>k", opts)
keymap("n", "<leader>ll", "<C-w>l", opts)

-- tabs
keymap("n", "<leader>to", "<cmd>tabedit %<cr>", opts)
keymap("n", "<leader>tc", "<cmd>tabclose<cr>", opts)
keymap("n", "<leader>tn", "<cmd>tabnext<cr>", opts)
keymap("n", "<leader>tp", "<cmd>tabprevious<cr>", opts)

-- qf list
keymap("n", "<leader>co", "<cmd>copen<cr>", opts)
keymap("n", "<leader>cc", "<cmd>cclose<cr>", opts)
keymap("n", "<leader>cn", "<cmd>cnext<cr>", opts)
keymap("n", "<leader>cp", "<cmd>cprev<cr>", opts)
keymap("n", "<leader>ch", "<cmd>chistory<cr>", opts)

-- resize
keymap("n", "<c-j>", ":resize +2<cr>", opts)
keymap("n", "<c-k>", ":resize -2<cr>", opts)
keymap("n", "<c-l>", ":vertical resize -2<cr>", opts)
keymap("n", "<c-h>", ":vertical resize +2<cr>", opts)

-- buffer nav
keymap("n", "<s-l>", ":bnext<cr>", opts)
keymap("n", "<s-h>", ":bprevious<cr>", opts)

-- crazy esc
keymap("i", "jk", "<esc>", opts)
keymap("i", "jj", "<esc>", opts)

-- no hls
keymap("n", "<leader>nh", ":nohls<cr>", opts)

-- insert newline stay in nromal mode
keymap("n", "<leader>o", 'o<esc>0"_d', opts)
keymap("n", "<leader>o", 'o<esc>0"_d', opts)

-- stay in indent mode
keymap("v", "<tab>", ">gv", opts)
keymap("v", "<s-tab>", "<gv", opts)

-- move text up down
keymap("v", "J", ":m '>+1<cr>gv=gv", opts)
keymap("v", "K", ":m '<-2<cr>gv=gv", opts)

-- Quick source with uncaching modules
function _G.ReloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match("^fgxhammer") then
			package.loaded[name] = nil
		end
	end
	-- Set $MYVIMRC
	dofile(vim.env.MYVIMRC)
end

-- keymap("n", "<Leader><leader>,", "<cmd>lua ReloadConfig()<cr>", opts)
-- vim.cmd('command! ReloadConfig lua ReloadConfig()')
