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
            ["<C-c>"] = { "close", mode = { "n", "i" } },
          }
        }
      }
    },
    words = {},
  },
  keys = {
    -- picker
    { "<C-p>",      function() Snacks.picker.files() end,      desc = "Find Files" },
    { "<leader>lg", function() Snacks.picker.grep() end,       desc = "Grep" },
    { ";",          function() Snacks.picker.resume() end,     desc = "Resume" },
    { "<leader>gc", function() Snacks.picker.git_log() end,    desc = "Git Log" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
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
