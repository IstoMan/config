-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Do not auto-insert comment leaders on <CR> or o/O (see :help fo-table, flags r and o).
-- Filetype plugins often re-add these; BufEnter reapplies after they run.
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("user_formatoptions_no_comment_leader", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})
