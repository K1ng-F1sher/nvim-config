return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- Conform will run the first available formatter
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          cs = { "csharpier" },
          -- lua = { "stylua" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      })
    end,
  },

  {
    'echasnovski/mini.nvim',
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('mini.ai').setup()
      require("mini.pairs").setup(
        {
          mappings = {
            ['('] = {
              action = 'open',
              pair = '()',
              neigh_pattern = '.[^%a%d]',
              { desc = "Don't open bracket when cursor is before an alphanumeric character" }
            },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '.[^%a%d]' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '.[^%a%d]' }, -- This bracket is here, b/c treesitter messes up: }

            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '.[^%a%d]', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '.[^%a%d]', register = { cr = false } },
          },
          -- skip autopair when next character is one of these
          skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
          -- skip autopair when next character is closing pair and there are more closing pairs than opening pairs
          skip_unbalanced = true,
          -- better deal with markdown code blocks
          markdown = true,
        }
      )
      require("mini.surround").setup()
    end,
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.3") == 1,
    opts = {},
  },

  {
    "Wansmer/treesj",
    keys = {
      "<leader>m",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

  {
    "mbbill/undotree",
    lazy = true,
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
      {
        "<leader>u",
        vim.cmd.UndotreeToggle,
        desc = "Undotree: Toggle Undotree",
      },
    },
    config = function(_, _)
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_DiffAutoOpen = 0
      vim.g.undotree_SplitWidth = 36

      if vim.fn.has("win32") == 1 then
        vim.g.undotree_DiffCommand = "FC"
      end
    end,
  },

}
