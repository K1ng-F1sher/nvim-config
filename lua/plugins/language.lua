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
      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        cssls = true,
        cssmodules_ls = true,
        jsonls = {
          settings = {
            json = {
              validate = { enable = true },
            },
          },
        },
        lua_ls = {
          settings = {
            server_capabilities = {
              semanticTokensProvider = vim.NIL,
            },
            Lua = {
              diagnostics = { disable = { 'missing-fields' } }
            }
          }
        },
        -- pylsp = true,
        roslyn = true,
        ts_ls = true,
      }

      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
        ensure_installed = {
          "cssls",
          "eslint",
          "lua_ls",
          "ts_ls",
        },
        automatic_installation = true,
        handlers = {
          powershell_es = function()
            lspconfig.powershell_es.setup({
              bundle_path = "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services",
              on_attach = function(_, bufnr)
                vim.api.nvim_buf_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
              end,
              settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
            })
          end,
        },
      })

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("blink.cmp").get_lsp_capabilities())

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          Map("n", "gl", function() vim.diagnostic.open_float() end)
          Map("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
          Map({ "n", "v" }, "<leader>vc", function() vim.lsp.buf.code_action() end)
          Map("n", "<leader>vh", function() vim.lsp.buf.signature_help() end)
          Map("n", "<leader>rn", function() vim.lsp.buf.rename() end)

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      {
        'DrKJeff16/wezterm-types',
        lazy = true,
        version = false, -- Get the latest version
      },
    },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = 'wezterm-types',      mods = { 'wezterm' } },
      },
    },
  },

  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    ft = { "cs", "razor" },
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },

  {
    "Kurren123/mssql.nvim",
    cmd = { 'MSSQL' },
    opts = {
      keymap_prefix = "<leader>m"
    },
  },

  {
    'saghen/blink.cmp',
    version = "1.*",
    event = "InsertEnter",

    ---@module 'blink.cmp'
    opts = {
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        menu = {
          auto_show = true,
          border = 'rounded',
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          window = { border = 'rounded' },
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
        accept = {
          auto_brackets = { enabled = false }
        },
      },

      fuzzy = {
        implementation = "prefer_rust"
      },

      -- experimental
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
        default = { "lazydev", "lsp", "path", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
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
    branch = 'main',
    build = ":TSUpdate",
    init = function()
        local ensure_installed = { "javascript", "c", "css", "c_sharp", "html", "lua", "vim", "markdown", "markdown_inline" }
        local alreadyInstalled = require("nvim-treesitter.config").get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
        	:filter(function(parser) return not vim.tbl_contains(alreadyInstalled, parser) end)
        	:totable()

        vim.defer_fn(function() require("nvim-treesitter").install(parser_installed) end, 1000)
        require("nvim-treesitter").update()

        -- auto-start highlights & indentation
            vim.api.nvim_create_autocmd("FileType", {
                desc = "User: enable treesitter highlighting",
                callback = function(ctx)
                    -- highlights
                    local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

                    -- indent
                    local noIndent = {}
                    if hasStarted and not vim.list_contains(noIndent, ctx.match) then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

      vim.treesitter.language.register('markdown', 'mdx')
    end
  },

}
