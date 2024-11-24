return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<C-c>", function()
			harpoon.ui:close_menu()
		end)
	end,
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add buffer to harpoon window",
		},
		{
			"<C-h>",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "",
		},
		{
			"<C-j>",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"<C-k>",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"<C-l>",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"<C-m>",
			function()
				require("harpoon"):list():select(4)
			end,
		},
		{
			"<C-n>",
			function()
				require("harpoon"):list():select(5)
			end,
		},
	},
}
