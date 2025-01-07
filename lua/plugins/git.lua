return {
  {
    "tpope/vim-fugitive",
    -- Can't use opts for fugitive, because it's not written in lua.
    config = function()
      Map("n", "<leader>ga", ":G add .<CR>")
      Map("n", "<leader>gc", ":G commit -m ''<Left>")
      Map("n", "<leader>gq", ":G commit . -m ''<Left>", { desc = "Remember by 'Git Quick commit'." })
      Map("n", "<leader>gp", ":G push<CR>", { silent = true })
      Map("n", "<leader>gl", ":G pull<CR>", { silent = true })
      Map(
        "n",
        "<leader>gt",
        ":G log --all --graph --decorate --oneline<CR><C-w>o",
        { silent = true, desc = "Show a tree of commit history" }
      )
      Map("n", "<leader>gd", ":Gvdiffsplit<CR><C-w>l", {
        silent = true,
        desc =
        "Get the two-way diff view for the current buffer and focus the split with new changes. Exit with: `<C-w>o`",
      })
    end,
  },
  {
    -- Enables `:GB` for Github
    "tpope/vim-rhubarb",
  },
  {
    -- Enables `:GB` for Azure Devops
    "cedarbaum/fugitive-azure-devops.vim",
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
}
