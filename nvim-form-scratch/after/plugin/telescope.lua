local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch [W]ord in working directory'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp_tags' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[S]earch [R]ecent files'})
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
