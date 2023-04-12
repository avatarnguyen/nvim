return {
	{ "nvim-lua/plenary.nvim" }, -- ful lua functions d by lots of plugins
	{
		"numToStr/Comment.nvim",
		config = function()
			require("user.comment")
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "moll/vim-bbye" },
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("user.toggleterm")
		end,
	},
	-- { "ahmedkhalf/project.nvim" },
	-- { "lewis6991/impatient.nvim" },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.indentline")
		end,
	},
	"b0o/schemastore.nvim",
	{
		"ray-x/lsp_signature.nvim",
		ft = { "go" },
	},

	-----------------
	-- Colorschemes
	-----------------
	{
		"folke/tokyonight.nvim",
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
		config = function()
			require("tokyonight").setup({
				style = "moon",
				-- style = "storm",
				-- style = "night",
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = { bold = true },
					variables = { italic = true },
					sidebars = "dark", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
			})
			-- vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.nightflyTransparent = 1
			vim.g.nightflyTerminalColors = 2
			vim.g.nightflyItalics = 1
			vim.g.nightflyNormalFloat = 1
			vim.g.nightflyCursorColor = 1
			vim.g.nightflyUndercurls = 1
			vim.g.nightflyUnderlineMatchParen = true
			vim.g.nightflyWinSeparator = 2
			vim.g.nightflyVirtualTextColor = true

			vim.cmd([[colorscheme nightfly]])
		end,
	},
	--"rebelot/kanagawa.nvim",
	--{
	--  'lalitmee/cobalt2.nvim',
	--  dependencies = 'tjdevries/colorbuddy.nvim',
	--},
	--{ "catppuccin/nvim",         name = "catppuccin" },
	--{ "Shatur/neovim-ayu" },

	------------------------
	-- File Tree
	------------------------
	{
		"kyazdani42/nvim-tree.lua",
		lazy = false,
		dependencies = {
			"antosha417/nvim-lsp-file-operations",
		},
		config = function()
			require("user.nvim-tree")
			require("lsp-file-operations").setup()
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		lazy = false,
		version = "v1.*",
		config = function()
			require("window-picker").setup()
		end,
	},
	-- {
	-- 	"folke/trouble.nvim",
	-- 	cmd = "TroubleToggle",
	-- 	config = function()
	-- 		require("user.trouble")
	-- 	end,
	-- },

	--------------
	-- CO-PILOT --
	--------------
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	-- cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("user.copilot")
	-- 	end,
	-- dependencies = {
	-- 	{
	-- 		"zbirenbaum/copilot-cmp",
	-- 		config = function()
	-- 			require("copilot_cmp").setup({
	-- 				formatters = {
	-- 					insert_text = require("copilot_cmp.format").remove_existing,
	-- 				},
	-- 			})
	-- 		end,
	-- 	},
	-- },
	-- },

	{
		"github/copilot.vim",
		config = function()
			require("user.copilot")
		end,
	},

	------------------------
	-- LSP Extra
	------------------------
	{ "RRethy/vim-illuminate" },
	{
		"rmagatti/goto-preview",
		config = function()
			require("user.preview")
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("user.lspsaga")
		end,
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	"onsails/lspkind.nvim",

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("user.colorizer")
		end,
	},

	------------------------
	-- DAP
	------------------------
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("user.lsp.dap")
		end,
	},

	------------------------
	-- GO
	------------------------
	{
		"olexsmir/gopher.nvim",
		ft = "go",
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
	},
	-- ('crispgm/nvim-go')
	--  "lvimr/lsp-inlayhints.nvim"

	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"sidlatau/neotest-dart",
		},
		config = function()
			require("user.neotest")
		end,
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"smartpde/telescope-recent-files",
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			{
				"junegunn/fzf",
				build = function()
					vim.fn["fzf#install"]()
				end,
			},
			{
				"AckslD/nvim-neoclip.lua",
				dependencies = {
					{ "tami5/sqlite.lua", module = "sqlite" },
				},
				config = function()
					require("user.neoclip")
				end,
			},
		},
		build = "make",
		config = function()
			require("user.telescope")
		end,
	},

	--------------------
	-- Treesitter
	--------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("user.treesitter")
		end,
	},
	-- Quickfix
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("user.bqf")
		end,
	},
	-- Git
	-- "tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("user.gitsigns")
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("user.diffview")
		end,
	},

	--------------------
	-- Frontend
	--------------------
	-- "windwp/nvim-ts-autotag",
	-- require("user.autotag")

	-- ('MunifTanjim/prettier.nvim')

	-- Editing {{{
	{
		"bkad/camelcasemotion",
		config = function()
			vim.g["camelcasemotion_key"] = "\\"
		end,
	},
	{
		"Mephistophiles/surround.nvim",
		config = function()
			require("user.surround")
		end,
	},
	"tpope/vim-repeat",
	-- Misc
	{
		"monaqa/dial.nvim",
		config = function()
			local augend = require("dial.augend")
			local keymap = vim.keymap.set
			require("dial.config").augends:register_group({
				-- default augends d when no group name is specified
				default = {
					augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
					augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
					augend.constant.alias.bool, -- boolean value (true <-> false)
				},
			})
			keymap("n", "<C-y>", require("dial.map").inc_normal())
			keymap("n", "<C-a>", require("dial.map").inc_normal())
			keymap("n", "<C-x>", require("dial.map").dec_normal())
			keymap("v", "<C-y>", require("dial.map").inc_visual())
			keymap("v", "<C-x>", require("dial.map").dec_visual())
			keymap("v", "g<C-y>", require("dial.map").inc_gvisual())
			keymap("v", "g<C-x>", require("dial.map").dec_gvisual())
		end,
	},

	------------------------
	-- Extra UI Plugins
	------------------------
	{
		"jiaoshijie/undotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("user.undotree")
		end,
	},
	{
		"opalmay/vim-smoothie",
		lazy = false,
		config = function()
			require("user.smoothie")
		end,
	},
	{
		"numToStr/Navigator.nvim",
		lazy = false,
		priority = 200,
		config = function()
			require("Navigator").setup({
				-- Save modified buffer(s) when moving to mux
				-- nil - Don't save (default)
				-- 'current' - Only save the current modified buffer
				-- 'all' - Save all the buffers
				auto_save = nil,
				-- Disable navigation when the current mux pane is zoomed in
				disable_on_zoom = true,
				-- Multiplexer to use
				-- 'auto' - Chooses mux based on priority (default)
				-- table - Custom mux to use
				mux = "auto",
			})
			vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
			vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
			vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
			vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
			vim.keymap.set({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>")
		end,
	},
	{
		"alexghergh/nvim-tmux-navigation",
		enabled = false,
		-- config = function()
		-- 	require("user.tmux-navigation")
		-- end,
	},
	-- "christoomey/vim-tmux-runner",
	{
		"folke/noice.nvim",
		lazy = false,
		priority = 100,
		config = function()
			require("user.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("user.notify")
				end,
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		enabled = false,
		config = function()
			require("user.fidget")
		end,
	},
	{
		"dstein64/vim-startuptime",
		-- lazy-load on a command
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("user.zenmode")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("user.whichkey")
		end,
	},
	"p00f/nvim-ts-rainbow",
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("user.harpoon")
		end,
	},
	{
		"Shatur/neovim-session-manager",
		config = function()
			require("user.session")
		end,
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("user.marks")
		end,
	},
	{
		"gbprod/substitute.nvim",
		config = function()
			require("substitute").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("user.todo-comment")
		end,
	},

	{
		"kazhala/close-buffers.nvim",
		config = function()
			require("user.buffer-close")
		end,
	},
	{
		"stevearc/overseer.nvim",
		cmd = { "OverseerToggle", "OverseerRunCmd" },
		config = function()
			require("user.overseer")
		end,
	},
	{
		"wakatime/vim-wakatime",
		lazy = false,
	},
}
