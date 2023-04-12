local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	vim.notify("Failed to load lspsaga", vim.log.levels.ERROR)
	return
end

saga.setup({
	ui = {
		-- This option only works in Neovim 0.9
		-- title = true,
		-- currently only round theme
		theme = "round",
		-- border type can be single,double,rounded,solid,shadow.
		border = "solid",
		winblend = 0,
		expand = "",
		collapse = "",
		preview = " ",
		code_action = "💡",
		diagnostic = "🐞",
		incoming = " ",
		outgoing = " ",
		colors = {
			--float window normal background color
			normal_bg = "#1d1536",
			--title background color
			title_bg = "#afd700",
			red = "#e95678",
			magenta = "#b33076",
			orange = "#FF8700",
			yellow = "#f7bb3b",
			green = "#afd700",
			cyan = "#36d0e0",
			blue = "#61afef",
			purple = "#CBA6F7",
			white = "#d1d4cf",
			black = "#1c1c19",
		},
		kind = {},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = true,
		sign = true,
		sign_priority = 2,
		virtual_text = false,
	},
	code_action = {
		num_shortcut = true,
		show_server_name = false,
		extend_gitsigns = true,
		keys = {
			-- string | table type
			quit = "q",
			exec = "<CR>",
		},
	},
	diagnostic = {
		max_height = 0.6,
		max_show_width = 0.9,
		max_show_height = 0.6,
		extend_relatedInformation = false,
		on_insert = false,
		on_insert_follow = false,
		insert_winblend = 0,
		show_virt_line = true,
		show_code_action = true,
		show_source = true,
		jump_num_shortcut = true,
		--1 is max
		max_width = 0.7,
		custom_fix = nil,
		custom_msg = nil,
		text_hl_follow = true,
		border_follow = true,
		keys = {
			exec_action = "o",
			quit = "q",
			go_action = "g",
		},
	},
	-- preview lines of lsp_finder and definition preview
	preview = {
		lines_above = 0,
		lines_below = 10,
	},
	scroll_preview = {
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
  hover = {
    max_width = 0.6,
    open_link = 'gx',
    open_browser = '!arc',
  },
	request_timeout = 2000,
	max_preview_lines = 20,
	finder_action_keys = {
		open = "o",
		vsplit = "s",
		split = "i",
		quit = "q",
		scroll_down = "<C-d>",
		scroll_up = "<C-u>", -- quit can be a table
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	rename_action_quit = "<C-c>",
	symbol_in_winbar = {
		enable = false,
		separator = " ",
		ignore_patterns = {},
		hide_keyword = true,
		show_file = false,
		folder_level = 1,
		respect_root = false,
		color_mode = true,
	},
	callhierarchy = {
		show_detail = false,
		keys = {
			edit = "e",
			vsplit = "s",
			split = "i",
			tabe = "t",
			jump = "o",
			quit = "q",
			expand_collapse = "u",
		},
	},
	beacon = {
		enable = true,
		frequency = 7,
	},
})
