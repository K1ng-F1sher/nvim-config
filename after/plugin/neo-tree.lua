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
vim.keymap.set("n", "<leader>v", function()
  vim.cmd("Neotree toggle")
end)
