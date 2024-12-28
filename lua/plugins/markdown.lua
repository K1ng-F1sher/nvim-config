return {
  {
    -- "OXY2DEV/markview.nvim",
    -- lazy = false,
    -- ft = "markdown",
    -- dependencies = {
    --   "nvim-treesitter/nvim-treesitter",
    --   "nvim-tree/nvim-web-devicons",
    -- },
    -- config = function()
    --   require("markview").setup({
    --     modes = { "n", "i", "no", "c" },
    --     hybrid_modes = { 'i' },
    --   })
    --
    --   vim.cmd("Markview enableAll")
    -- end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }
}
