return {
  "mbbill/undotree",
  lazy = true,
  cmd = { "UndotreeToggle", "UndotreeShow" },
  keys = {
    {
      "<leader>u",
      vim.cmd.UndotreeToggle,
      desc = "Undotree: Toggle Undotree",
    },
  },
  config = function(_, _)
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_DiffAutoOpen = 0
    vim.g.undotree_SplitWidth = 36

    if vim.fn.has("win32") == 1 then
      vim.g.undotree_DiffCommand = "FC"
    end
  end,
}
