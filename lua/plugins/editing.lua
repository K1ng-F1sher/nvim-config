return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
        toml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        -- cs = { "csharpier" },
        -- lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    }
  },

  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    keys = {
      {
        "<leader>q",
        function()
          require("quicker").toggle({ focus = true })
        end,
        desc = "Toggle quickfix",
      }
    },
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },

  {
    'nvim-mini/mini.nvim',
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('mini.ai').setup()
      require("mini.surround").setup()
      require('mini.cmdline').setup({})
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = { "BufReadPre", "BufNewFile" },
    opts = {}
  },

  {
    'danymat/neogen',
    version = '*',
    config = {
      enabled = true,
      languages = {
        cs = {
          template = {
            annotation_convention = "xmldoc" -- for a full list of annotation_conventions, see supported-languages below,
          }
        },
      }
    },
    keys = {
      {
        "<leader>ca",
        function()
          require('neogen').generate()
        end,
        desc = "Create Summary",
      }
    },
  },

  {
    "folke/ts-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    opts = {
      ui = { compact = true }
    },
    keys = {
      {
        "<leader>u",
        "<cmd>Atone toggle<cr>",
        desc = "Toggle Undotree",
      },
    },
  },

  {
    'kevinhwang91/nvim-fundo',
    lazy = true,
    dependencies = { 'kevinhwang91/promise-async' },
    run = { function() require('fundo').install() end }
  },
}
