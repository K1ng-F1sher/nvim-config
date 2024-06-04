local map = vim.keymap.set

-- Explorer
map("n", "<leader>pv", function() vim.cmd("Neotree position=current") end)
map("n", "<leader>e", function()
  vim.cmd("Neotree toggle")
end)

-- Editing
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-a>", "ggVG")
map({ "n", "v" }, "<leader>y", "\"*y")
map({ "n", "v" }, "<leader>p", "\"*p")

map("n", "<leader>f", vim.lsp.buf.format)

-- Commenting (can't get it to work yet, "gc" works tho)
map("n", "<C-_>", "Vgc")
map("v", "<C-_>", "gc")

-- Navigating
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Exiting
map("i", "<C-c>", "<Esc>")
map("n", "Q", "<nop>")

map("n", "<leader><leader>", function()
  vim.cmd("so")
end)
