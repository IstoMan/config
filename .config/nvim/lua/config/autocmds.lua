local augroup = vim.api.nvim_create_augroup("ChadNvimAutocmds", { clear = true })

-- Feedback: briefly highlight text after yanking so the copied range is obvious.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Files: create missing parent directories before saving a new file path.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  desc = "Create missing parent directories before write",
  callback = function(event)
    if event.match == "" or vim.bo[event.buf].buftype ~= "" then
      return
    end

    local file = vim.uv.fs_realpath(event.match) or event.match
    local dir = vim.fn.fnamemodify(file, ":p:h")

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Files: trim trailing whitespace on save without moving the cursor.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  desc = "Trim trailing whitespace before saving",
  callback = function(event)
    if vim.bo[event.buf].buftype ~= "" or vim.bo[event.buf].binary then
      return
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor)
  end,
})

-- Editing: reopen files at the last known cursor position when it is valid.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  desc = "Restore cursor to last edit position",
  callback = function(event)
    local exclude = { gitcommit = true }
    if exclude[vim.bo[event.buf].filetype] or vim.bo[event.buf].buftype ~= "" then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Layout: keep splits balanced when the editor is resized.
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  desc = "Resize splits evenly when Neovim is resized",
  command = "tabdo wincmd =",
})

-- Editing: disable autopairs in prompts and plain Vim command buffers.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "TelescopePrompt", "vim" },
  desc = "Disable mini.pairs in prompt buffers",
  callback = function()
    vim.b.minipairs_disable = true
  end,
})

-- Writing: make prose-oriented buffers easier to edit.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "markdown", "text" },
  desc = "Enable wrapping and spell checking for prose",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

-- Temporary windows: close common utility buffers with q.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "checkhealth", "help", "lspinfo", "man", "qf" },
  desc = "Close temporary windows with q",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = event.buf,
      desc = "Close window",
      silent = true,
    })
  end,
})

-- Terminal: make terminal buffers behave like terminals, not code buffers.
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  desc = "Start terminal buffers in insert mode",
  callback = function(event)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.bo[event.buf].buflisted = false
    vim.cmd.startinsert()
  end,
})

-- LSP: register buffer-local mappings only after a language server attaches.
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  desc = "Attach LSP navigation and code action keymaps",
  callback = function(event)
    local buf = event.buf
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc, silent = true })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "Go to references")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>la", vim.lsp.buf.code_action, "Code actions")
    map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
  end,
})
