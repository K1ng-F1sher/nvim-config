hhsreturn {
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
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    -- Enables `:GB` for Azure Devops
    "cedarbaum/fugitive-azure-devops.vim",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = { "AdvancedGitSearch" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
      "tpope/vim-rhubarb",
      "cedarbaum/fugitive-azure-devops.vim",
    },
    config = function()
      require("telescope").setup({
        browse_command = "GBrowse {commit_hash}",
        diff_plugin = "fugitive",                -- one of fugitive or diffview
        show_builtin_git_pickers = false,
        entry_default_author_or_date = "author", -- one of "author" or "date"
        keymaps = {
          toggle_date_author = "<C-a>",
          open_commit_in_browser = "<C-o>",
          copy_commit_hash = "<C-y>",
          show_entire_commit = "<C-e>",
        },
      })
      require("telescope").load_extension("advanced_git_search")
    end,
    keys = {
      {
        "<leader>gH",
        "<cmd>AdvancedGitSearch search_log_content<cr>",
        desc = "AdvancedGitSearch through git commit history",
      }
    },
  },
}
