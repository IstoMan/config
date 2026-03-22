return {
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = false, -- defaults to false
      })

      vim.keymap.set("n", "<c-h>", nvim_tmux_nav.nvimtmuxnavigateleft)
      vim.keymap.set("n", "<c-j>", nvim_tmux_nav.nvimtmuxnavigatedown)
      vim.keymap.set("n", "<c-k>", nvim_tmux_nav.nvimtmuxnavigateup)
      vim.keymap.set("n", "<c-l>", nvim_tmux_nav.nvimtmuxnavigateright)
      vim.keymap.set("n", "<c-\\>", nvim_tmux_nav.nvimtmuxnavigatelastactive)
      vim.keymap.set("n", "<c-space>", nvim_tmux_nav.nvimtmuxnavigatenext)
    end,
  },
}
