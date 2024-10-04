local centerCallback = function()
  vim.api.nvim_create_autocmd("CursorMoved", {
    once = true,
    callback = function()
      if vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" then
        vim.cmd("norm! zz")
      end
    end,
  })
end

return
{
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
          },
          n = {
            ["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
          }
        }
      }
    }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
    vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
    vim.keymap.set('n', ';', builtin.resume, {})
    vim.keymap.set('n', 'gr', function()
      centerCallback()
      builtin.lsp_references()
    end, { desc = "Show a list of all references and center when selecting one of them" })
    vim.keymap.set('n', 'gi', function()
      centerCallback()
      builtin.lsp_implementations()
    end, { desc = "Show a list of all imlpementations and center when selecting one of them" })
    vim.keymap.set('n', 'gd', function()
      centerCallback()
      builtin.lsp_definitions()
    end, { desc = "Show a list of all definitions and center when selecting one of them" })
    vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, {})
    vim.keymap.set('n', 'gq', builtin.quickfix, {})
  end
}
