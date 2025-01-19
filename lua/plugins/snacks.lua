return
{
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        {
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    picker = {
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
    { "<leader>gl", function() Snacks.picker.git_log() end,              desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end,           desc = "Git Status" },
    ---- search
    { "<leader>lg", function() Snacks.picker.grep() end,                 desc = "Live Grep" },
    { "<leader>sj", function() Snacks.picker.jumps() end,                desc = "Search Jumps" },
    { "<leader>sq", function() Snacks.picker.qflist() end,               desc = "Quickfix List" },
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
}
