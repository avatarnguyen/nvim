local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  vim.notify("Failed to load lspsaga", "error")
  return
end

saga.setup {
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 2,
    virtual_text = false,
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = 'q',
      exec = '<CR>',
    },
  },
  diagnostic = {
    twice_into = false,
    show_code_action = true,
    show_source = true,
    keys = {
      exec_action = 'o',
      quit = 'q',
    },
  },
  -- preview lines of lsp_finder and definition preview
  preview = {
    lines_above = 0,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = '<C-f>',
    scroll_up = '<C-b>',
  },
  request_timeout = 2000,
  max_preview_lines = 20,
  finder_action_keys = {
    open = 'o', vsplit = 's', split = 'i', quit = 'q', scroll_down = '<C-d>', scroll_up = '<C-u>' -- quit can be a table
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_quit = "<C-c>",
  symbol_in_winbar = {
    enable = false,
    separator = ' ',
    hide_keyword = true,
    show_file = false,
    folder_level = 2,
  },
}
-- vim.wo.winbar = require('lspsaga.symbolwinbar'):get_winbar()
