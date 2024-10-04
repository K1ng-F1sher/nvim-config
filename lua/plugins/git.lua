return {
  {
    "tpope/vim-fugitive",
    -- Can't use opts for fugitive
    config = function()
      -- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
      vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR><C-w>l")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {}
  },
}
