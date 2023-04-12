return {
	"neovim/nvim-lspconfig",
  lazy = false,
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
		-- { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"jayp0521/mason-null-ls.nvim",
		"jayp0521/mason-nvim-dap.nvim",
	},
	config = function()
		require("user.lsp.handlers").setup()
	end,
}
