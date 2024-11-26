local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
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

-- netrw
-- keymap("n", "<Leader>e", ":Ex<CR>", opts)

-- tmux session
keymap("", "<C-f>", ":silent !tmux neww tmux_session_find.sh<CR>", opts)

-- crazy save
keymap("n", "<Leader>w", ":w<CR>", opts)

-- clear highlight and errors on ESC
keymap("n", "<Esc>", "<Cmd>noh<CR><Bar><Cmd>echon<CR><CR>", opts)

-- save and source file
keymap("n", "<Leader>xx", ":w<CR>:source %<CR>", opts)

-- Copy current filename to system clipboard
keymap("n", "<Leader>cf", CopyFileNameToClipBoard, opts)

-- find and replace word under cursor
keymap("n", "<Leader>*", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- dont overwrite paste register
keymap("v", "p", '"_dP', opts)

-- U for Redo
keymap("n", "U", "<C-r>", opts)

-- alternate file
keymap("n", "<Leader>a", "<C-^>", opts)

-- split panes
keymap("n", "<Leader>%", "<Cmd>vs<CR>", opts)
keymap("n", '<Leader>"', "<Cmd>sp<CR>", opts)

-- pane navigation
keymap("n", "<Leader>h", "<C-w>h", opts)
keymap("n", "<Leader>j", "<C-w>j", opts)
keymap("n", "<Leader>k", "<C-w>k", opts)
keymap("n", "<Leader>l", "<C-w>l", opts)
keymap("n", "<Leader>q", "<C-w>q", opts)
keymap("n", "<Leader>o", "<C-w>o", opts)

-- vertical navigation
keymap("n", "<C-d>", "<c-d>zz", opts)
keymap("n", "<C-u>", "<c-u>zz", opts)

-- qf list
keymap("n", "<Leader>co", "<Cmd>copen<CR>", opts)
keymap("n", "<Leader>cc", "<Cmd>cclose<CR>", opts)
keymap("n", "<Leader>cn", "<Cmd>cnext<CR>", opts)
keymap("n", "<Leader>cp", "<Cmd>cprev<CR>", opts)
keymap("n", "<Leader>ch", "<Cmd>chistory<CR>", opts)

-- tabs
keymap("n", "<Leader>to", "<Cmd>tabedit %<CR>", opts)
keymap("n", "<Leader>tc", "<Cmd>tabclose<CR>", opts)
keymap("n", "<Leader>tn", "<Cmd>tabnext<CR>", opts)
keymap("n", "<Leader>tp", "<Cmd>tabprevious<CR>", opts)

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
keymap("n", "<Leader>o", "o<esc>", opts)
keymap("n", "<Leader>O", "O<esc>", opts)

-- stay in indent mode
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- move text up down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- keymaps for commands
keymap("n", "<Leader>bf", "<Cmd>Format<CR>",opts)
keymap("n", "<Leader>be", "<Cmd>EslintFix<CR>",opts)
keymap("n", "<Leader>bp", "<Cmd>Prettier<CR>",opts)

