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
          -- cs = { "csharpier" },
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
    'echasnovski/mini.nvim',
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('mini.ai').setup()
      require("mini.surround").setup()
    end,
  },

  {
    "folke/ts-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
