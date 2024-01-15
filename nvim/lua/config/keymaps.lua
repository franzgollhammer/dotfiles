local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- remove default
keymap("", "<Space>", "<Nop>", opts)

-- modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",

-- crazy save
keymap("n", "Q", ":q<cr>", opts)
keymap("n", "zz", "zz :update<cr>", opts)

-- clear highlight and errors
keymap("n", "<CR>", "<Cmd>noh<CR><Bar><Cmd>echon<CR><CR>", opts)

-- netrw
-- keymap("n", "<leader>e", ":Ex<cr>", opts)

-- git
keymap("n", "<leader>gg", ":G<cr>", opts)

-- tmux session
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-session-find<CR>")

-- find and replace word under cursor
keymap("n", "<leader>*", ":%s/<C-r><C-w>/", opts)

-- dont overwrite paste register
keymap("v", "p", '"_dP', opts)

-- yank word under cursor
keymap("n", "<leader>y", "yiw", opts)

-- yank in quotes
keymap("n", "<leader>'", "yi'", opts)
keymap("n", '<leader>"', 'yi"', opts)
keymap("n", "<leader>`", "yi`", opts)
keymap("n", "<leader><", "yi<", opts)

-- paste in quotes
keymap("n", "<leader>p'", "vi'p", opts)
keymap("n", '<leader>p"', 'vi"p', opts)
keymap("n", "<leader>p`", "vi`p", opts)
keymap("n", "<leader>p<", "vi<p", opts)

-- alternate file
keymap("n", "<leader>a", "<C-^>", opts)

-- pane navigation
keymap("n", "<leader>wh", "<C-w>h", opts)
keymap("n", "<leader>wj", "<C-w>j", opts)
keymap("n", "<leader>wk", "<C-w>k", opts)
keymap("n", "<leader>wl", "<C-w>l", opts)
keymap("n", "<leader>wq", "<C-w>q", opts)

-- vertical
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- qf list
keymap("n", "<leader>co", "<cmd>copen<cr>", opts)
keymap("n", "<leader>cc", "<cmd>cclose<cr>", opts)
keymap("n", "<leader>cn", "<cmd>cnext<cr>", opts)
keymap("n", "<leader>cp", "<cmd>cprev<cr>", opts)
keymap("n", "<leader>ch", "<cmd>chistory<cr>", opts)

-- tabs
keymap("n", "<leader>to", "<cmd>tabedit %<cr>", opts)
keymap("n", "<leader>tc", "<cmd>tabclose<cr>", opts)
keymap("n", "<leader>tn", "<cmd>tabnext<cr>", opts)
keymap("n", "<leader>tp", "<cmd>tabprevious<cr>", opts)

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

-- insert newline stay in nromal mode
keymap("n", "<leader>o", "o<ESC>", opts)
keymap("n", "<leader>O", "O<ESC>", opts)

-- stay in indent mode
keymap("v", "<tab>", ">gv", opts)
keymap("v", "<s-tab>", "<gv", opts)

-- move text up down
keymap("v", "J", ":m '>+1<cr>gv=gv", opts)
keymap("v", "K", ":m '<-2<cr>gv=gv", opts)
