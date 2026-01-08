return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- Set the list of linters for 'markdown' to an empty table {} to disable them.
        markdown = {},
        -- You can keep other filetype linters if you want, or just include
        -- the filetypes you need to modify. LazyVim merges tables.
      },
    },
  },
}
