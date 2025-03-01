return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "saadparwaiz1/cmp_luasnip" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      local lsp = require("lsp-zero")

      lsp.preset("recommended")

      require("mason").setup({})

      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "lua_ls",
        },
        automatic_installation = true,
        handlers = {
          lsp.default_setup,

          powershell_es = function()
            local lspconfig = require("lspconfig")
            lspconfig.powershell_es.setup({
              on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
              end,
              settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
            })
          end,
        },
      })

      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sign_icons = {},
      })

      lsp.extend_lspconfig()
      lsp.on_attach(function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }

        Map("n", "K", function() vim.lsp.buf.hover() end, opts)
        Map("n", "gl", function() vim.diagnostic.open_float() end, opts)
        Map("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        Map("n", "<leader>vd", function() vim.diagnostics.open_float() end, opts)
        Map("n", "[d", function() vim.diagnostics.goto_next() end, opts)
        Map("n", "]d", function() vim.diagnostics.goto_prev() end, opts)
        Map("n", "<leader>vc", function() vim.lsp.buf.code_action() end, opts)
        Map("n", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)
        Map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
      end)

      lsp.setup()
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "javascript", "c", "html", "lua", "vim", "markdown", "markdown_inline" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }

      vim.treesitter.language.register('markdown', 'mdx')
    end
  },

  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = "Trouble",
    keys = { -- '{' for prev and '}' for next
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle focus=true<cr>",
        desc = "Diagnostics (Trouble)",
      },
    }
  }
}
