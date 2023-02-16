local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  vim.notify("Failed to load lspsaga", "error")
  return
end

saga.setup {
  ui = {
    -- currently only round theme
    theme = 'round',
    -- border type can be single,double,rounded,solid,shadow.
    border = 'solid',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal background color
      normal_bg = '#1d1536',
      --title background color
      title_bg = '#afd700',
      red = '#e95678',
      magenta = '#b33076',
      orange = '#FF8700',
      yellow = '#f7bb3b',
      green = '#afd700',
      cyan = '#36d0e0',
      blue = '#61afef',
      purple = '#CBA6F7',
      white = '#d1d4cf',
      black = '#1c1c19',
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
    num_shortcut = false,
    keys = {
      quit = 'q',
      exec = '<CR>',
    },
  },
  diagnostic = {
    twice_into = true,
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
    enable = true,
    separator = ' ',
    hide_keyword = true,
    show_file = true,
    folder_level = 1,
  },
}
-- vim.wo.winbar = require('lspsaga.symbolwinbar'):get_winbar()
