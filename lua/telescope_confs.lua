require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}

require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap("n", "<space>fe", ":Telescope file_browser<CR>",{ noremap = true })

vim.api.nvim_set_keymap("n", "<space>fc", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",{ noremap = true })

-- Map the Telescope current buffer fuzzy find command
vim.api.nvim_set_keymap('n', '<leader>sw', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
