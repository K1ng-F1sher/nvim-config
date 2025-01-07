local list = function(num)
  require("harpoon"):list():select(num)
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()

    Map("n", "<C-c>", function()
      harpoon.ui:close_menu()
    end)
  end,
  keys = {
    {
      "<leader>a",
      function() require("harpoon"):list():add() end,
      desc = "Add buffer to harpoon window",
    },
    { "<C-h>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
    { "<C-j>", function() list(1) end },
    { "<C-k>", function() list(2) end },
    { "<C-l>", function() list(3) end },
    { "<C-m>", function() list(4) end },
    { "<C-n>", function() list(5) end },
  },
}
