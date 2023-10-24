vim.wo.relativenumber = true
vim.wo.number = true
vim.o.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.hlsearch = false
vim.o.incsearch = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vimdir/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
-- disable nvim intro
vim.opt.shortmess:append "sI"
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
-- so to ignore - : and other things like that
vim.cmd "set whichwrap+=<,>,[,],h,l"
