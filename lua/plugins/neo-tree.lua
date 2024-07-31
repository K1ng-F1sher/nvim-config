return
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    --"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
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

    vim.keymap.set("n", "<leader>e", function() vim.cmd("Neotree position=current") end)
  end,
  opts = {
    event_handlers = { {
      event = "neo_tree_buffer_enter", -- neo_tree_buffer_enter 
      handler = function()
        vim.cmd("setrelativenumber")
      end,
    } },
  },
}
