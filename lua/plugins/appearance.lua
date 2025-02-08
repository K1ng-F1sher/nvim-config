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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
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
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          -- {
          --   icon = " ",
          --   title = "Git Status",
          --   section = "terminal",
          --   enabled = function()
          --     return Snacks.git.get_root() ~= nil
          --   end,
          --   cmd = "git status --short --branch --renames",
          --   height = 5,
          --   padding = 1,
          --   ttl = 5 * 60,
          --   indent = 3,
          -- },
          { section = "startup" },
        },
      },
      picker = {
        matcher = { frecency = true },
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
      words = {},
    },
    keys = {
      -- picker
      ---- find
      { "<C-p>",      function() Snacks.picker.files() end,                desc = "Find Files" },
      { "<leader>ls", function() Snacks.picker.buffers() end,              desc = "Buffers" },
      { ";",          function() Snacks.picker.resume() end,               desc = "Resume" },
      ---- git
      { "<leader>gh", function() Snacks.picker.git_grep() end,             desc = "Git History" },
      { "<leader>gl", function() Snacks.picker.git_log() end,              desc = "Git Log" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,         desc = "Git Log File" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end,         desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end,           desc = "Git Status" },
      ---- search
      { "<leader>lg", function() Snacks.picker.grep() end,                 desc = "Live Grep" },
      { "<leader>jl", function() Snacks.picker.jumps() end,                desc = "Jump List" },
      { "<leader>qf", function() Snacks.picker.qflist() end,               desc = "QuickFix list" },
      ---- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
      { "gr",         function() Snacks.picker.lsp_references() end,       nowait = true,                desc = "References" },
      { "gi",         function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
      { "gt",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
      { "gs",         function() Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols" },

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

  {
    "folke/zen-mode.nvim",
    lazy = false,
    opts = {},
    keys = {
      {
        "<leader>z",
        function() require("zen-mode").toggle() end,
      }
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
