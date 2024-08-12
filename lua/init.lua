
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'Mofiqul/dracula.nvim'  
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim' 
  use 'phaazon/hop.nvim'
  use 'nvim-neotest/nvim-nio'
  use 'akinsho/nvim-toggleterm.lua'
  use 'windwp/nvim-autopairs'
  use 'nvim-neotest/nvim-nio'
--  use 'kyazdani42/nvim-tree.lua'
  use({"nvim-neo-tree/neo-tree.nvim",
       requires = {
	    "nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	   }
  })
  --use 'nvim-tree/nvim-web-devicons'
  use 'voldikss/vim-floaterm'
  use 'vim-airline/vim-airline'
  use 'morhetz/gruvbox'
  --use 'ryanoasis/vim-devicons'
  --use 'kyazdani42/nvim-web-devicons' 
  use 'akinsho/bufferline.nvim'
  --use 'github/copilot.vim'
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use 'mfussenegger/nvim-dap-python'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'simrat39/rust-tools.nvim'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'preservim/tagbar'
  use {
      'stevearc/aerial.nvim',
  }
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  -- do a :TSInstall all 
  use({'nvim-treesitter/nvim-treesitter',
       run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end})
  use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    })
  use { "ibhagwan/fzf-lua",
     -- optional for icon support
    requires = { "nvim-tree/nvim-web-devicons" }
    }
  use({ "junegunn/fzf", run = "./install --bin" })
  use({"HUAHUAI23/telescope-dapzzzz"})
  --use({'MunifTanjim/nui.nvim'})
  use({'nvimtools/none-ls.nvim'})
  use({
      "goolord/alpha-nvim",
      requires = {"nvim-tree/nvim-web-devicons"}
  })
  use({
      "yorickpeterse/nvim-window",
  })
  use({
       "folke/trouble.nvim",
       requires={ "nvim-tree/nvim-web-devicons" }
  })
end)

for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua', [[v:val =~ '\.lua$' && v:val != 'init.lua']])) do
    require(file:gsub('%.lua$', ''))
end


