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
