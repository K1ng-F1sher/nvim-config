return {
  "folke/zen-mode.nvim",
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader>z",
      function() require("zen-mode").toggle() end,
    }
  }
}
