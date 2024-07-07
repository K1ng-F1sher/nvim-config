return {

  'tpope/vim-fugitive',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  'theprimeagen/harpoon',

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      --"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
    'smoka7/hop.nvim',
    -- tag = '*', -- optional but strongly recommended
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },

  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' }
    }
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    }
  }
  -- {
  --   'folke/trouble.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --
  --   config = function()
  --     require("trouble").setup({
  --       icons = false,
  --     })
  --
  --     vim.keymap.set("n", "<leader>tt", function()
  --       require("trouble").toggle()
  --     end)
  --
  --     vim.keymap.set("n", "[t", function()
  --       require("trouble").next({ skip_groups = true, jump = true });
  --     end)
  --
  --     vim.keymap.set("n", "]t", function()
  --       require("trouble").previous({ skip_groups = true, jump = true });
  --     end)
  --   end
  -- },
}
