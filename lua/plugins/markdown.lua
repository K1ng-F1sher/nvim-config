return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local markview = require("markview")
    local presets = require("markview.presets")

    require("markview").setup({
      modes = { "n", "i", "no", "c" },

      hybrid_modes = { "i" },

      -- This is nice to have
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = "c"
        end,
      },
    })

    vim.cmd("Markview enableAll")
  end,
}
