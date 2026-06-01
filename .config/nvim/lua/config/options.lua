local opt = vim.opt

-- Use Space as the prefix for custom shortcuts.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
opt.number = true -- Show absolute line number on the cursor line.
opt.relativenumber = true -- Show relative line numbers for easier motions.
opt.cursorline = true -- Highlight the line the cursor is on.
opt.signcolumn = "yes" -- Keep the sign column visible so text does not shift.
opt.termguicolors = true -- Enable true color support in capable terminals.
opt.scrolloff = 8 -- Keep context above and below the cursor.
opt.sidescrolloff = 8 -- Keep context left and right when scrolling horizontally.
opt.cmdheight = 1 -- Reserve one line for the command area.
opt.showmode = false -- Hide mode text, since statuslines usually show it.
opt.splitright = true -- Open vertical splits to the right.
opt.splitbelow = true -- Open horizontal splits below.
opt.list = true -- Show subtle markers for hidden whitespace.
opt.listchars = {
  tab = "  ",
  trail = ".",
  extends = ">",
  precedes = "<",
  nbsp = "+",
}

-- Editing
opt.expandtab = true -- Insert spaces when pressing Tab.
opt.shiftwidth = 2 -- Use two spaces for each indent step.
opt.tabstop = 2 -- Display Tab characters as two spaces wide.
opt.softtabstop = 2 -- Make editing tabs feel like two spaces.
opt.smartindent = true -- Apply basic language-aware indentation.
opt.wrap = false -- Keep long lines on one screen line by default.
opt.breakindent = true -- Preserve indentation when wrapped lines are enabled.
opt.linebreak = true -- Wrap long lines at word boundaries when wrapping is enabled.
opt.virtualedit = "block" -- Allow block selections past line endings.

-- Search
opt.ignorecase = true -- Search case-insensitively by default.
opt.smartcase = true -- Use case-sensitive search when uppercase is included.
opt.incsearch = true -- Preview matches while typing a search.
opt.hlsearch = true -- Highlight search results until cleared.

-- Files
opt.swapfile = false -- Do not create swap files.
opt.backup = false -- Do not keep backup files after writing.
opt.writebackup = false -- Avoid temporary backup files during writes.
opt.undofile = true -- Persist undo history between sessions.
opt.updatetime = 250 -- Trigger CursorHold and diagnostics sooner.
opt.timeoutlen = 300 -- Shorten mapped-sequence wait time.

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" } -- Better popup menu behavior for completion.

-- GNOME + Wayland: wl-copy can steal focus / block on notifications under Mutter.
-- Prefer xclip through XWayland when available, matching the previous stable setup.
local desk = vim.env.XDG_CURRENT_DESKTOP or ""
local gnome = desk:find("GNOME") ~= nil
if vim.fn.has("gui_running") == 0 and vim.env.XDG_SESSION_TYPE == "wayland" and gnome and vim.fn.executable("xclip") == 1 then
  vim.g.clipboard = {
    name = "xclip",
    copy = {
      ["+"] = { "xclip", "-selection", "clipboard" },
      ["*"] = { "xclip", "-selection", "primary" },
    },
    paste = {
      ["+"] = { "xclip", "-selection", "clipboard", "-o" },
      ["*"] = { "xclip", "-selection", "primary", "-o" },
    },
    cache_enabled = true,
  }
end
