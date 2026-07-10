return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        -- Conform will run the first available formatter
        javascript = { "prettier" },
        typescript = { "prettier", "eslint_d", stop_after_first = false },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier", "eslint_d", stop_after_first = false },
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
    opts = { enable_close = false, }
  },

  {
    'danymat/neogen',
    version = '*',
    config = {
      enabled = true,
      languages = {
        cs = {
          template = {
            annotation_convention = "xmldoc"
          }
        },
      }
    },
    keys = {
      {
        "<leader>sa",
        function()
          require('neogen').generate()
        end,
        desc = "Summary Add",
      }
    },
  },

  {
    "folke/ts-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    'coder/claudecode.nvim',
    dependencies = { "folke/snacks.nvim" },
    config = true,
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>c",  nil,                              desc = "AI/Claude Code" },
      { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>cs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      -- Diff management
      { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
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
