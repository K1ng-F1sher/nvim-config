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
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.3") == 1,
    opts = {},
  },
  {
    "saecki/live-rename.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      Map("n", "<leader>rn", require("live-rename").map({ insert = true }), { desc = "LSP rename" })
    end,
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
    'echasnovski/mini.nvim',
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('mini.ai').setup()
      require("mini.pairs").setup(
        {
          mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^%a\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^%a\\].' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^%a\\].' },

            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^%a\\].', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^%a\\].', register = { cr = false } },
          }
        }
      )
      require("mini.surround").setup()
    end,
  },
}
