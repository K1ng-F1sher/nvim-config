return
{
  'smoka7/hop.nvim',
  -- tag = '*', -- optional but strongly recommended
  config = function()
    require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

    vim.keymap.set("", "S", "<cmd>HopWord<CR>", { noremap = false })
    vim.keymap.set("", "<Leader>j", "<cmd>HopLineAC<CR>", { noremap = true })
    vim.keymap.set("", "<Leader>k", "<cmd>HopLineBC<CR>", { noremap = true })
  end
}
