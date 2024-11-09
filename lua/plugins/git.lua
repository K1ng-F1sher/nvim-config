return {
	{
		"tpope/vim-fugitive",
		-- Can't use opts for fugitive, because it's not written in lua.
		config = function()
			vim.keymap.set("n", "<leader>ga", ":G add .<CR>")
			vim.keymap.set("n", "<leader>gc", ":G commit -m ''<Left>")
			vim.keymap.set("n", "<leader>gbc", ":G commit . -m ''<Left>", { desc = "Remember by 'git bulk commit'." })
			vim.keymap.set("n", "<leader>gp", ":G push<CR>")
			vim.keymap.set("n", "<leader>gg", ":G pull<CR>", { desc = "Remember by 'git get'." })
			vim.keymap.set("n", "<leader>gf", ":G fetch<CR>")
			vim.keymap.set("n", "<leader>gpom", ":G pull origin main<CR>")
			vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR><C-w>l", {
				desc = "Get the two-way diff view for the current buffer and focus the split with new changes. Easiest way to exit: `<C-w>o`",
			})
		end,
	},

	{
		"lewws6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
