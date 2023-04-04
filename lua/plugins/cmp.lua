return {
	"hrsh7th/nvim-cmp",
	version = false, -- last release is way too old
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-buffer", -- buffer completions
		"hrsh7th/cmp-path", -- path completions
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
    {
      "L3MON4D3/LuaSnip",
			config = function()
        require("user.luasnip")
			end,
    }, --snippet engine
		"rafamadriz/friendly-snippets",
		{
			"windwp/nvim-autopairs",
			config = function()
				require("user.autopairs")
			end,
		},
	},
	config = function()
		vim.g.cmp_active = true
		require("user.cmp")
	end,
}
