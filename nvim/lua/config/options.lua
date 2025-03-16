vim.g.have_nerd_font = true
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
vim.opt.cursorlineopt = { "number" }
vim.opt.cursorline = true
vim.opt.expandtab = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- disable nvim intro
vim.opt.shortmess:append("sI")
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

-- so to ignore - : and other things like that
vim.cmd("set whichwrap+=<,>,[,],h,l")

-- So that extra comments don't come when going to the next line
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=cro")
