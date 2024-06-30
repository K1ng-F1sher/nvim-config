return {
  -- Theme
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        disable_italics = true,
        styles = {
          italic = false,
        },
      })

      vim.cmd("colorscheme rose-pine")
    end
  },
}
