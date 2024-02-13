local hop = require('hop')

vim.keymap.set("", "S", "<cmd>HopWord<CR>", {noremap=false})
vim.keymap.set("", "<leader>f", "<cmd>HopChar1AC<CR>", {noremap=false})
vim.keymap.set("", "<leader>F", "<cmd>HopChar1BC<CR>", {noremap=false})
vim.keymap.set("", "<leader><leader>f", "<cmd>HopChar2AC<CR>", {noremap=true})
vim.keymap.set("", "<leader><leader>F", "<cmd>HopChar2BC<CR>", {noremap=true})
vim.keymap.set("", "<Leader>j", "<cmd>HopLineAC<CR>", {noremap=true})
vim.keymap.set("", "<Leader>k", "<cmd>HopLineBC<CR>", {noremap=true})
