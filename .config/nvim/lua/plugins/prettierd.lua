-- Discussion #1957: prettier CLI is slow on large TS projects; prettierd keeps a daemon hot.
-- LazyVim ships the prettier extra; we swap conform's formatter name and ensure Mason installs prettierd.
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      for _, formatters in pairs(opts.formatters_by_ft or {}) do
        if type(formatters) == "table" then
          for i, name in ipairs(formatters) do
            if name == "prettier" then
              formatters[i] = "prettierd"
            end
          end
        end
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "prettierd" })
    end,
  },
}
