return {
	"williamboman/mason.nvim",
  lazy = false,
	-- keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	-- opts = {
	-- 	ensure_installed = {
	-- 		"stylua",
	-- 		"shfmt",
	-- 		"flake8",
	-- 	},
	-- },
	-- config = function(_, opts)
	config = function()
    -- require("user.lsp.handlers").setup()
    require('user.lsp.mason')
	end,
}
