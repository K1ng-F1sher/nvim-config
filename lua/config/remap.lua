---------------
--- Editing ---
---------------
Map("v", "J", ":m '>+1<CR>gv=gv", { desc = "switch the currently selected line and the line below, then format" })
Map("v", "K", ":m '<-2<CR>gv=gv", { desc = "switch the currently selected line and the line above, then format" })
Map("i", "<C-H>", "<C-W>", { noremap = true, desc = "sets <C-BS> to <C-W>" })

Map("n", "<leader>f", vim.lsp.buf.format)

Map("n", "<leader>rp", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "find and RePlace word under cursor" })

-----------------
--- Clipboard ---
-----------------
Map("n", "<C-a>", "ggVG")
Map("v", "y", "ygv<esc>", { remap = true, desc = "stay in visual mode after yanking" })
Map("n", "gy", "[v]", { desc = 'select recently pasted, yanked or changed text' })
Map({ "n", "v" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })
Map({ "n", "v" }, "<leader>d", '"_d', { desc = "delete and send the deleted text to the void register" })
Map({ "n", "v" }, "<leader>D", '"_D', { desc = "delete the rest of the line and send to the void register" })
Map("x", "<leader>p", '"_dP', { desc = "keep your selection in register when pasting over another selection" })

------------------
--- Commenting ---
------------------
Map("n", "<C-_>", "Vgc", { remap = true, desc = "comment out a line (<C-_> equals <C-/>)" })
Map("v", "<C-_>", "gc", { remap = true })

------------------
--- Navigating ---
------------------
Map({ "n", "v" }, "H", "^", { remap = true, desc = "move to the start of the line with a sensible key" })
Map({ "n", "v" }, "L", "$", { remap = true, desc = "move to the end of the line with a sensible key" })
Map("i", "<C-l>", "<esc>A", { desc = "Move to the end of the line in insert mode" })
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

----------------
--- Viewport ---
----------------
Map("n", "<leader>rc", "<cmd>set conceallevel=0<CR>", { desc = "Reset Conceallevel" })

---------------
--- Exiting ---
---------------
Map("i", "<C-c>", "<Esc>")
Map("n", "Q", "<nop>")
Map("t", "<C-c><C-c>", "<c-\\><c-n>", { desc = "exit terminal mode" })
