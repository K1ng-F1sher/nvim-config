return
{
  'smoka7/hop.nvim',
  version = '*',
  config = function()
    require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    vim.keymap.set("", "S", "<cmd>HopWord<CR>", { noremap = false })
  end,
  keys = {
    "S"
  }
}
