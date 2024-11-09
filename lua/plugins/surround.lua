return {
	"echasnovski/mini.surround",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		require("mini.surround").setup()
	end,
}
