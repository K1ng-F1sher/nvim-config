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
    "folke/ts-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
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

  {
    'kevinhwang91/nvim-fundo',
    lazy = true,
    dependencies = { 'kevinhwang91/promise-async' },
    run = { function() require('fundo').install() end }
  },
}
