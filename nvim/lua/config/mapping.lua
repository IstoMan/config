local keymap = vim.keymap.set
-- Create opts with your existing settings plus room for descriptions
local function dopts(description)
    return { noremap = true, silent = true, desc = description }
end
local term_opts = { silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text easily
keymap("v", "J", ":m '>+1<CR>gv=gv", dopts("Move text Down"))
keymap("v", "K", ":m '<-2<CR>gv=gv", dopts("Move text Up"))
keymap("x", "<leader>p", [["_dP]], dopts("Paste without yanking"))

-- For tmux like navigation
keymap("n", "<leader>%", ":vsplit<CR>", dopts("Split Vertical"))
keymap("n", "<leader>\"", ":split<CR>", dopts("Split Horizontal"))
keymap("n", "<leader>x", ":close<CR>", dopts("Close window"))

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", dopts("Resize height +"))
keymap("n", "<C-Down>", ":resize -2<CR>", dopts("Resize height -"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", dopts("Resize width -"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", dopts("Resize width +"))

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", dopts("Buffer Next"))
keymap("n", "<S-h>", ":bprevious<CR>", dopts("Buffer Previous"))

-- Neogit
keymap("n", "<leader>gg", ":Neogit<CR>", dopts("[G]it status"))

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
