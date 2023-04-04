return {
	"akinsho/flutter-tools.nvim",
	dependencies = "nvim-lua/plenary.nvim",
  ft = { "dart" },
	config = function()
		require("flutter-tools").setup({
			ui = {
				border = "shadow",
			},
			-- flutter_path = "$HOME/fvm/default", -- <-- this takes priority over the lookup
			-- flutter_path = "$HOME/flutter/bin/flutter/", -- <-- this takes priority over the lookup
			fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
			dev_log = {
				enabled = false,
				open_cmd = "tabedit",
			},
			dev_tools = {
				autostart = true, -- autostart devtools server if not detected
				auto_open_browser = true, -- Automatically opens devtools in the browser
			},
			widget_guides = {
				enabled = true,
			},
			closing_tags = {
				enabled = true, -- set to false to disable
			},
			outline = {
				open_cmd = "50vnew", -- command to use to open the outline buffer
				auto_open = false, -- if true this will open the outline automatically when it is first populated
			},
			decorations = {
				statusline = {
					app_version = false,
					device = false,
				},
			},
			debugger = {
				-- integrate with nvim dap + install dart code debugger
				enabled = true,
				run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
				register_configurations = function(_)
					require("user.lsp.dap")
				end,
			},
			lsp = {
				color = {
					-- show the derived colours for dart variables
					enabled = true,
					background = false, -- highlight the background
					-- background_color = nil, -- required, when background is transparent
					background_color = { r = 19, g = 17, b = 24 },
					foreground = false, -- highlight the foreground
					virtual_text = true, -- show the highlight using virtual text
					virtual_text_str = "■■", -- the virtual text character to highlight
				},
				on_attach = function(client, bufnr)
					require("user.lsp.handlers").on_attach(client, bufnr)
					vim.g.dart_style_guide = 2
					vim.g.dart_format_on_save = 1
					-- if colorscheme == "nightfly" then
					 vim.cmd "highlight FlutterWidgetGuides ctermfg=9 guifg=#82aaff"
					--elseif colorscheme == "github" then
					--  vim.cmd "highlight FlutterWidgetGuides ctermfg=9 guifg=#56d4dd"
					--else
					-- vim.cmd("highlight FlutterWidgetGuides ctermfg=9 guifg=cyan")
					-- end

					--[[ vim.cmd "highlight FlutterWidgetGuides ctermfg=9 guifg=#72A7BC" ]]
				end,
				-- capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
				--- OR you can specify a function to deactivate or change or control how the config is created
				-- capabilities = function(config)
				--   return config
				-- end,
				settings = {
					showTodos = false,
					completeFunctionCalls = true,
					analysisExcludedFolders = {
						".dart_tool",
						vim.fn.expand("$HOME/flutter/.pub-cache"),
						vim.fn.expand("$HOME/fvm"),
						vim.fn.expand("$HOME/flutter/packages"),
						vim.fn.expand("~/flutter/packages"),
					},
					renameFilesWithClasses = "prompt", -- "always"
					enableSnippets = true,
					lineLength = 2000,
				},
			},
		})
	end,
}
