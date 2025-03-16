return {
  { "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        custom_highlights = function(colors)
          return {
            LineNr = {fg = colors.overlay0},
          }
        end,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = {
            enabled = true,
          },
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        }
      }
    end,},
}
