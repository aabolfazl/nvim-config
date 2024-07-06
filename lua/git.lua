require('gitsigns').setup()
vim.keymap.set('n', "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set('n', "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
vim.keymap.set('n', "<F2>", ":Git blame<CR>", {})
vim.keymap.set('i', "<F2>", "<esc>:Git blame<CR>i", {})


