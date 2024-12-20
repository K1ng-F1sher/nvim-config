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

local telescope = require("telescope")
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- If the line below doesn't work, cd to %LOCALAPPDATA%/nvim-data/lazy/telescope-fzf and execute `make`
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      config = function()
        telescope.load_extension("fzf")
      end,
    },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<CR>"] = actions.select_default + actions.center,
            ["<BS>"] = false,
            ["<C-u>"] = false, -- <C-u> now clears the prompt.
          },
          n = {
            ["<CR>"] = actions.select_default + actions.center,
          },
        },
      },
    })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
    vim.keymap.set("n", "<C-p>", builtin.find_files, {})
    vim.keymap.set("n", "<leader>gs", function()
      centerCallback()
      builtin.git_status()
    end, {})
    vim.keymap.set("n", ";", builtin.resume, {})
    vim.keymap.set("n", "gr", function()
      centerCallback()
      builtin.lsp_references()
    end, { desc = "Show a list of all references and center when selecting one of them" })
    vim.keymap.set("n", "gi", function()
      centerCallback()
      builtin.lsp_implementations()
    end, { desc = "Show a list of all imlpementations and center when selecting one of them" })
    vim.keymap.set("n", "gd", function()
      centerCallback()
      builtin.lsp_definitions()
    end, { desc = "Show a list of all definitions and center when selecting one of them" })
    vim.keymap.set("n", "gt", builtin.lsp_type_definitions, {})
    vim.keymap.set("n", "gq", builtin.quickfix, {})
  end,
}
