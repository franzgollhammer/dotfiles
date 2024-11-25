local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
-- TODO: 
-- modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",
--
--  Disable space bar
keymap("n", "<Space>", "<Nop>", opts)

-- tmux session
keymap("", "<C-f>", ":silent !tmux neww tmux_session_find.sh<CR>", opts)

-- crazy save
keymap("n", "<leader>w", ":w<CR>", opts)

-- clear highlight and errors on ESC
keymap("n", "<ESC>", "<Cmd>noh<CR><Bar><Cmd>echon<CR><CR>", opts)

-- save and source file
keymap("n", "<leader>xx", ":w<CR>:source %<CR>", opts)

-- netrw
-- keymap("n", "<leader>e", ":Ex<CR>", opts)

-- find and replace word under cursor
keymap("n", "<leader>*", ":%s/<C-r><c-w>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- dont overwrite paste register
keymap("v", "p", '"_dP', opts)

-- Goto start/end of line
-- keymap("n", "H", "^", opts)
-- keymap("n", "L", "$", opts)

-- U for Redo
keymap("n", "U", "<C-r>", opts)

-- yank word under cursor
keymap("n", "<leader>y", "yiw", opts)

-- alternate file
keymap("n", "<leader>p", "<C-^>", opts)

-- split panes
keymap("n", "<leader>%", "<cmd>vs<CR>", opts)
keymap("n", '<leader>"', "<cmd>sp<CR>", opts)

-- pane navigation
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)
keymap("n", "<leader>q", "<C-w>q", opts)
keymap("n", "<leader>o", "<C-w>o", opts)

-- vertical navigation
keymap("n", "<C-d>", "<c-d>zz", opts)
keymap("n", "<C-u>", "<c-u>zz", opts)

-- qf list
keymap("n", "<leader>co", "<cmd>copen<CR>", opts)
keymap("n", "<leader>cc", "<cmd>cclose<CR>", opts)
keymap("n", "<leader>cn", "<cmd>cnext<CR>", opts)
keymap("n", "<leader>cp", "<cmd>cprev<CR>", opts)
keymap("n", "<leader>ch", "<cmd>chistory<CR>", opts)

-- tabs
keymap("n", "<leader>to", "<cmd>tabedit %<CR>", opts)
keymap("n", "<leader>tc", "<cmd>tabclose<CR>", opts)
keymap("n", "<leader>tn", "<cmd>tabnext<CR>", opts)
keymap("n", "<leader>tp", "<cmd>tabprevious<CR>", opts)

-- resize
keymap("n", "<C-j>", ":resize -2<CR>", opts)
keymap("n", "<C-k>", ":resize +2<CR>", opts)
keymap("n", "<C-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-l>", ":vertical resize +2<CR>", opts)

-- buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- crazy esc
keymap("i", "jk", "<esc>", opts)
keymap("i", "jj", "<esc>", opts)

-- insert newline stay in nromal mode
keymap("n", "<leader>o", "o<esc>", opts)
keymap("n", "<leader>O", "O<esc>", opts)

-- stay in indent mode
keymap("v", "<tab>", ">gv", opts)
keymap("v", "<S-tab>", "<gv", opts)

-- move text up down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

