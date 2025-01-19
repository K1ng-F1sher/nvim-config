return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "open_current",
        window = {
          mappings = {
            ["-"] = "navigate_up",
            ["<bs>"] = "noop",
            ["Z"] = "expand_all_nodes",
          },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        event_handlers = {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd("set rnu") -- This doesn't seem to work.
          end,
        },
      },

      -- Map("n", "<leader>e", function()
      --   vim.cmd("Neotree reveal position=current")
      --   vim.cmd("set rnu")
      -- end),
    },
    keys = { { "<leader>e", function()
      vim.cmd("Neotree reveal position=current")
      vim.cmd("set rnu")
    end } }
  },

  {
    "echasnovski/mini.files",
    version = "*",
    opts = {
      mappings = {
        close = "<C-c>",
        go_in_plus = "<CR>",
      },
      options = {
        use_as_default_explorer = false,
      },

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
          vim.wo[args.data.win_id].relativenumber = true
        end,
      }),
    },
    keys = {
      {
        "-",
        "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>",
      },
    },
  },
}
