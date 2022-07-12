local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  vim.notify("Failed to load lspsaga", "error")
  return
end

saga.init_lsp_saga {
  -- use emoji
  -- like {'🙀','😿','😾','😺'}
  -- diagnostic_header_icon = {'😡', '😥', '😤', '😐'}, --{ ' ', ' ', ' ', 'ﴞ ' },
  -- show diagnostic source
  show_diagnostic_source = true,
  -- add bracket or something with diagnostic source,just have 2 elements
  diagnostic_source_bracket = { '❴', '❵' },
  -- use emoji lightbulb in default
  -- code_action_icon = '💡',
  -- if true can press number to execute the codeaction in codeaction window
  code_action_num_shortcut = true,
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = false,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 15,
  finder_action_keys = {
    open = 'o', vsplit = 's', split = 'i', quit = 'q', scroll_down = '<C-d>', scroll_up = '<C-u>' -- quit can be a table
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_quit = "<C-c>",
  --  rename_action_keys = {
  --    quit = '<C-c>', exec = '<CR>' -- quit can be a table
  --  },
  definition_preview_icon = '  ',
  -- "single" "double" "rounded" "bold" "plus"
  -- border_style = "single",
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = {metals = {'sbt', 'scala'}}
  -- server_filetype_map = {},
  symbol_in_winbar = {
    in_custom = true,
    enable = true,
    separator = ' ',
    show_file = true,
  },
}
local action = require("lspsaga.action")
-- scroll down hover doc or scroll in definition preview
vim.keymap.set("n", "<C-j>", function()
  action.smart_scroll_with_saga(1)
end, { silent = true })
-- scroll up hover doc
vim.keymap.set("n", "<C-k>", function()
  action.smart_scroll_with_saga(-1)
end, { silent = true })

-- local ns_prefix = '%#MyWinbar#test%*'
--
-- local function config_winbar()
--   local ok,lspsaga = pcall(require,'lspsaga.symbolwinbar')
--   local sym
--   if ok then
--     sym = lspsaga.get_symbol_node()
--   end
--   local win_val = ''
--   win_val = ns_prefix
--   if sym ~= nil then
--     win_val = win_val .. sym
--   end
--   vim.api.nvim_win_set_option(0,'winbar',win_val)
-- end
--
-- vim.api.nvim_create_autocmd({'BufEnter','BufWinEnter','CursorMoved'},{
--   pattern = '*.dart',
--   callback = config_winbar
-- })
--
-- vim.api.nvim_create_autocmd({'BufEnter','BufWinEnter','CursorMoved'},{
--   pattern = '*.lua',
--   callback = config_winbar
-- })
