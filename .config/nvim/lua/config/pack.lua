if vim.pack == nil then
  error("This config uses vim.pack and requires Neovim 0.12 or newer.")
end

vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/folke/flash.nvim" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/nvim-mini/mini.ai" },
  { src = "https://github.com/jake-stewart/multicursor.nvim", version = "1.0" },
})

local function build_fzf_native()
  local plugin_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
  local lib = plugin_dir .. "/build/libfzf." .. (vim.uv.os_uname().sysname == "Darwin" and "dylib" or "so")

  if vim.fn.filereadable(lib) == 1 then
    return
  end

  if vim.fn.executable("make") == 0 then
    vim.notify("telescope-fzf-native.nvim needs `make` to build the fzf extension.", vim.log.levels.WARN)
    return
  end

  local result = vim.system({ "make" }, { cwd = plugin_dir, text = true }):wait()
  if result.code ~= 0 then
    vim.notify("Failed to build telescope-fzf-native.nvim:\n" .. (result.stderr or ""), vim.log.levels.WARN)
  end
end

build_fzf_native()

require("tokyonight").setup({
  style = "moon",
  terminal_colors = true,
})
vim.cmd.colorscheme("tokyonight")

require("nvim-web-devicons").setup({
  color_icons = true,
  default = true,
  strict = true,
})

require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
  win_options = {
    wrap = true,
  },
})

require("telescope").setup({})
pcall(require("telescope").load_extension, "fzf")

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        desc = desc,
        silent = true,
      })
    end

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, "Next git hunk")

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, "Previous git hunk")

    map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
    map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Stage selected hunk")
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Reset selected hunk")
    map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
    map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
    map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end, "Blame line")
    map("n", "<leader>hd", gitsigns.diffthis, "Diff this")
    map("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end, "Diff this against last commit")
    map("n", "<leader>hq", gitsigns.setqflist, "Send hunks to quickfix")
    map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select git hunk")
  end,
})

require("neogit").setup({
  integrations = {
    telescope = true,
  },
})

require("flash").setup({})

require("mini.pairs").setup()

-- Surround: gs* prefix avoids conflict with Flash on `s`.
require("mini.surround").setup({
  mappings = {
    add = "gsa",
    delete = "gsd",
    replace = "gsr",
    find = "gsf",
    find_left = "gsF",
    highlight = "gsh",
    suffix_next = "n",
    suffix_last = "l",
  },
})

require("mini.ai").setup()

require("config.multicursor")
