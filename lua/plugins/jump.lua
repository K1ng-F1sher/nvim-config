return {
  {
    "smoka7/hop.nvim",
    version = "*",
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
      vim.keymap.set("n", "<leader>s", "<cmd>HopWord<CR>", { noremap = false })
    end,
    keys = {
      "<leader>s",
    },
  },
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set('n', 'S', '<Plug>(leap)')
    end,
    keys = {
      'S',
    },
  }
}
