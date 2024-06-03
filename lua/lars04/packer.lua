-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use ('wbthomason/packer.nvim')

  -- Theme
  use({ 'rose-pine/neovim',
  as = 'rose-pine',
  config = function()
    require('rose-pine').setup({
      disable_background = true,
      disable_italics = true,
      styles = {
        italic = false,
      },
    })

    vim.cmd("colorscheme rose-pine")
  end
  })

  -- (File) Navigation
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.3',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use('theprimeagen/harpoon')
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      --"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  }
  use { 'fgheng/winbar.nvim' }
  use({ 'SmiteshP/nvim-navic', as = 'nvim-navic' })
  use {
      'smoka7/hop.nvim',
      tag = '*', -- optional but strongly recommended
      config = function()
          require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
  }

  -- LSP
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-path'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-nvim-lua'},
          {'saadparwaiz1/cmp_luasnip'},

          -- Snippets
          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'}
      }
  }

  use {
       'folke/trouble.nvim',
       version = '2.*',
       requires = { 'nvim-tree/nvim-web-devicons' },
       config = function()
            require("trouble").setup({
                icons = false,
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end)

        end
  }

end)


