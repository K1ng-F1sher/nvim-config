return
{
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    words = {}
  },
  keys = {
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
