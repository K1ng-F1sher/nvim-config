return {
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
