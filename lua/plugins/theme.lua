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

      function ColorMyPencils(color)
        color = color or "rose-pine"
        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end

    end
  },
}
