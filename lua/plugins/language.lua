return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      'saghen/blink.cmp'
    },
    config = function()
      local capabilities = nil
      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        lua_ls = true,
        cssls = true,
        csharp_ls = true,
        ts_ls = true,
        jsonls = {
          settings = {
            json = {
              validate = { enable = true },
            },
          },
        },
      }

      require("mason").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "lua_ls",
          "cssls",
        },
        automatic_installation = true,
        handlers = {
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

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          Map("n", "K", function() vim.lsp.buf.hover() end)
          Map("n", "gl", function() vim.diagnostic.open_float() end)
          Map("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
          Map("n", "<leader>vd", function() vim.diagnostics.open_float() end)
          Map("n", "[d", function() vim.diagnostics.goto_next() end)
          Map("n", "]d", function() vim.diagnostics.goto_prev() end)
          Map("n", "<leader>vc", function() vim.lsp.buf.code_action() end)
          Map("n", "<leader>vh", function() vim.lsp.buf.signature_help() end)
          Map("n", "<leader>rn", function() vim.lsp.buf.rename() end)

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })
    end,
  },

  {
    'saghen/blink.cmp',
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",

    ---@module 'blink.cmp'
    opts = {
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = 'rounded',
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          -- auto_show_delay_ms = 200,
          window = { border = 'rounded' },
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental signature help support
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          max_width = 160,
          max_height = 30,
          scrollbar = false,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      cmdline = {
        enabled = false,
      },

      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-n>'] = { 'select_next', 'show' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<C-p>'] = { 'select_prev' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
    },
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
