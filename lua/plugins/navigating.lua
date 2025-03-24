local list = function(num)
  require("harpoon"):list():select(num)
end

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup({
        settings = {
          sync_on_ui_close = false,
        }
      })

      Map("n", "<C-c>", function()
        harpoon.ui:close_menu()
      end)

      -- Create an autocmd that saves the last line number for harpooned buffers
      vim.api.nvim_create_autocmd({ "BufLeave", "ExitPre" }, {
        pattern = "*",
        callback = function()
          local filename = vim.fn.expand("%:p:.")
          local harpoon_marks = harpoon:list().items
          for _, mark in ipairs(harpoon_marks) do
            if mark.value == filename then
              mark.context.row = vim.fn.line(".")
              mark.context.col = vim.fn.col(".")
              return
            end
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>a",
        function() require("harpoon"):list():add() end,
        desc = "Add buffer to harpoon window",
      },
      { "<C-h>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
      { "<C-j>", function() list(1) end },
      { "<C-k>", function() list(2) end },
      { "<C-l>", function() list(3) end },
      { "<C-m>", function() list(4) end },
      { "<C-n>", function() list(5) end },
    },
  },

  {
    "ggandor/leap.nvim",
    config = function()
      Map('n', 'S', '<Plug>(leap)')
    end,
    keys = {
      'S',
    },
  },

  {
    "unblevable/quick-scope",
    config = function()
      vim.g.qs_buftype_blacklist = { 'terminal', 'nofile', 'nowrite' }
    end
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
