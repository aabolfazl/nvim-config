-- for hop
require'hop'.setup()
vim.api.nvim_set_keymap('n', '<leader>jj', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>jc', "<cmd>lua require'hop'.hint_char1()<cr>", { noremap=true, silent=true })



-- for autopairs
require('nvim-autopairs').setup{}

-- for bufferline
require("bufferline").setup{
    options = {
        show_buffer_close_icons = false,
    }
}

