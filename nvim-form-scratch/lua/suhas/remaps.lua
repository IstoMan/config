local keymap = vim.keymap.set
local opts = { noremap = true, silent = true}
local term_opts = { silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text easily
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<leader>p", [["_dP]], opts)
-- Seperation between system clipboard and neovim registors
keymap({"n", "v"}, "<leader>y", [["+y]], opts)
keymap("n", "<leader>Y", [["+Y]] ,opts)
keymap({"n", "v"}, "<leader>p", [["+p]], opts)
keymap("n", "<leader>P", [["+P]], opts)
-- For tmux like navigation
keymap("n", "<leader>%", ":vsplit<CR>" ,opts)
keymap("n", "<leader>\"",":split<CR>", opts)
keymap("n", "<leader>x",":close<CR>", opts)
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
