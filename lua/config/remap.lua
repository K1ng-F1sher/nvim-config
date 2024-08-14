local map = vim.keymap.set

-- Editing
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map('i', '<C-H>', '<C-W>', { noremap = true, desc = "sets <C-BS> to <C-W>" }) 

map("n", "<C-a>", "ggVG")
map("v", "y", "ygv<esc>", { remap = true })
map({ "n", "v" }, "<leader>y", "\"+y", { desc = "copy to system clipboard" })

map({ "n", "v" }, "<leader>d", "\"_d", { desc = "delete and send the deleted text to the void register" })
map("x", "<leader>p", "\"_dP", { desc = "keep your selection in register when pasting over another selection" })

map("n", "<leader>f", vim.lsp.buf.format)

-- Commenting
map("n", "<C-_>", "Vgc", { remap = true })
map("v", "<C-_>", "gc", { remap = true })

-- Navigating
map("n", "H", "^", { remap = true })
map("n", "L", "$", { remap = true })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Exiting
map("i", "<C-c>", "<Esc>")
map("n", "Q", "<nop>")
