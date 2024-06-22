 
require('nvim-window').setup({
  normal_hl = 'BlackOnLightYellow',
  hint_hl = 'Bold',
  border = ''
})

vim.keymap.set('n', "<S-Tab>", "<cmd>lua require('nvim-window').pick()<cr>", {desc = "nvim-window: Jump to window"})
