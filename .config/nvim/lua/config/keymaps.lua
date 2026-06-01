local map = vim.keymap.set

-- Navigation: keep the cursor centered during common jumps and search movement.
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down", silent = true })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up", silent = true })
map("n", "n", "nzzzv", { desc = "Next search result", silent = true })
map("n", "N", "Nzzzv", { desc = "Previous search result", silent = true })

-- Text editing: move selections, join lines cleanly, and paste without clobbering registers.
map("n", "J", "mzJ`z", { desc = "Join line without moving cursor", silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Files: fast access to common save, quit, search, and selection commands.
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight", silent = true })
map("n", "<leader>a", "ggVG", { desc = "Select all", silent = true })

-- Buffers: move between open files and clean up buffer lists.
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer", silent = true })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer", silent = true })
map("n", "<leader>n", "<cmd>enew<CR>", { desc = "New buffer", silent = true })

-- Files and search: Oil for file editing, Telescope for fuzzy finding.
map("n", "e", "<cmd>Oil<CR>", { desc = "Open parent directory", silent = true })
map("n", "<leader><leader>", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files", silent = true })
map("n", "<leader>fg", function()
  require("telescope.builtin").git_files()
end, { desc = "Find git files", silent = true })
map("n", "<leader>fs", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep", silent = true })
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Find buffers", silent = true })
map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Find help", silent = true })
map("n", "<leader>fr", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Find recent files", silent = true })
map("n", "<leader>fw", function()
  require("telescope.builtin").grep_string()
end, { desc = "Grep word under cursor", silent = true })
map("n", "<leader>fc", function()
  require("telescope.builtin").command_history()
end, { desc = "Command history", silent = true })

-- Windows: use Ctrl plus home-row keys to move around splits and arrows to resize.
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window", silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window", silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window", silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window", silent = true })
map("n", "<Up>", "<cmd>resize +2<CR>", { desc = "Increase window height", silent = true })
map("n", "<Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height", silent = true })
map("n", "<Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width", silent = true })
map("n", "<Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width", silent = true })

-- Clipboard: explicit system clipboard and black-hole register helpers.
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard", silent = true })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking", silent = true })
map("n", "<leader>p", [["+p]], { desc = "Paste from system clipboard", silent = true })
map("n", "<leader>P", [["+P]], { desc = "Paste before from system clipboard", silent = true })
map("x", "<leader>p", [["_d"+P]], { desc = "Paste from system clipboard without yanking replaced text", silent = true })

-- Git: Neogit provides an interactive Git status and command interface.
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Neogit", silent = true })

-- Flash: fast jump/search motions using Lua callbacks to preserve dot-repeat.
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash jump", silent = true })
map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter", silent = true })
map("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash", silent = true })
map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Flash Treesitter search", silent = true })
map("c", "<C-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash search", silent = true })

-- Terminal: double Escape returns to normal mode from terminal buffers.
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
