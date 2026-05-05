-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.mouse = ""
vim.o.guifont = "Jetbrains Mono:h12"

-- GNOME + Wayland: wl-copy steals focus / blocks on notifications (Mutter).
-- OSC 52 in practice was worse here (timeouts, paste hangs). xclip hits XWayland
-- but is the stable fix until Neovim/GNOME clipboard story improves.
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
