return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          hijack_netrw_behavior = "open_current",
          window = {
            mappings = {
              ["-"] = "navigate_up",
            }
          },
        },
      })

      vim.keymap.set("n", "<leader>e", function()
        vim.cmd("Neotree position=current")
        vim.cmd("set rnu")
      end)
    end,
  },

  {
    'echasnovski/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup(
        {
          mappings = {
            close = "<C-c>",
            go_in_plus = "<CR>",
          },
          options = {
            -- Whether to use for editing directories
            use_as_default_explorer = false,
          },
        }
      )

      -- vim.keymap.set("n", "<leader>m", "<cmd>lua MiniFiles.open()<CR>")
      vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>")

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowUpdate',
        callback = function(args) vim.wo[args.data.win_id].relativenumber = true end,
      })
    end
  },
}
