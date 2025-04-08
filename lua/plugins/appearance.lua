return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = {
        char = { "│" },
      },
      scope = {
        enabled = false,
      },
    },
  },

  {
    "bluz71/nvim-linefly",
    lazy = false,
    config = function()
      vim.g.linefly_options = {
        error_symbol = "󰅚",
        warning_symbol = "󰀪",
        information_symbol = "",
      }
    end
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    cmd = { "RenderMarkdown" },
    event = { "BufReadPre", "BufNewFile" },
    ---@module 'render-markdown'
    opts = {},
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = {},
      dashboard = {
        sections = {
          {
            text =
            [[
                                         
      ████ ██████           █████      ██                 btw
 ███████████             █████ 
    █████████ ███████████████████ ███   ███████████
   █████████  ███    █████████████ █████ ██████████████
  █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
          },
          { section = "startup", padding = 1 },
          { section = "keys", padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
          { section = "terminal", cmd = "curl -s 'wttr.in/?0'", padding = 1, height = 8 },
        },
      },
      explorer = {},
      picker = {
        matcher = { frecency = true },
        sources = {
          explorer = {
            auto_close = true,
            jump = { close = true },
            win = {
              list = {
                keys = { ["<C-c>"] = { "close", mode = { "n", "i" } }, },
                wo = { number = true, relativenumber = true, cursorline = true },
              }
            },
            layout = {
              preview = false,
              layout = {
                backdrop = false,
                row = 1,
                number = false,
                relativenumber = false,
                width = 0.6,
                min_width = 80,
                height = 0.8,
                border = "rounded",
                box = "vertical",
                { win = "input",   height = 1,          border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                { win = "list",    border = "hpad" },
                { win = "preview", title = "{preview}", border = "rounded" },
              },
            }
          }
        },
        win = {
          input = {
            keys = {
              ["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },    -- Forward
              ["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },      -- Back
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },   -- Up
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } }, -- Down
              ["<C-c>"] = { "close", mode = { "n", "i" } },
              ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            }
          }
        }
      },
      quickfile = {},
      words = {},


    },
    keys = {
      -- picker
      ---- find
      { "<C-p>",            function() Snacks.picker.files() end,                desc = "Find Files" },
      { "<leader>ls",       function() Snacks.picker.buffers() end,              desc = "Buffers" },
      { "<leader><leader>", function() Snacks.picker.resume() end,               desc = "Resume" },
      ---- git
      -- { "<leader>gl", function() Snacks.picker.git_log() end,              desc = "Git Log" }, use <leader>gt instead
      { "<leader>gf",       function() Snacks.picker.git_log_file() end,         desc = "Git Log File" },
      { "<leader>gL",       function() Snacks.picker.git_log_line() end,         desc = "Git Log Line" },
      { "<leader>gs",       function() Snacks.picker.git_status() end,           desc = "Git Status" },
      { "<leader>e",        function() Snacks.explorer() end,                    desc = "File Explorer" },
      ---- search
      { "<leader>lg",       function() Snacks.picker.grep() end,                 desc = "Live Grep" },
      { "<leader>jl",       function() Snacks.picker.jumps() end,                desc = "Jump List" },
      { "<leader>qf",       function() Snacks.picker.qflist() end,               desc = "QuickFix list" },
      { "<leader>ch",       function() Snacks.picker.command_history() end,      desc = "Command History" },
      { "<leader>tt",       function() Snacks.picker.diagnostics() end,          desc = "Toggle Trouble (Diagnostics)" },
      { "<leader>nh",       function() Snacks.picker.notifications() end,        desc = "Notification History" },
      ---- LSP
      { "gd",               function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
      { "gr",               function() Snacks.picker.lsp_references() end,       nowait = true,                        desc = "References" },
      { "gi",               function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
      { "gt",               function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
      { "gs",               function() Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols" },

      -- words
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
          vim.cmd("norm! zz")
        end,
        desc = 'Next Reference',
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
          vim.cmd("norm! zz")
        end,
        desc = 'Prev Reference',
      },
    }
  },

  ---------------
  --- THEMES ----
  ---------------
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        disable_background = true,
        disable_italics = true,
        styles = {
          italic = false,
          transparency = true
        },
      })

      function ColorMyPencils(color)
        color = color or "rose-pine"
        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end
    end
  },

  {
    'Mofiqul/vscode.nvim',
    as = 'vscode',
  },

  {
    "folke/tokyonight.nvim",
    as = 'tokyonight',
    config = function()
      require("tokyonight").setup({
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        disable_background = true,
        styles = {
          italic = false,
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent",   -- style for floating windows
        },
      })

      vim.cmd("colorscheme tokyonight")
    end
  }
}
