local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  vim.notify("Failed to load lspsaga", "error")
  return
end

saga.init_lsp_saga {
  code_action_lightbulb = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = false,
  },
  -- preview lines of lsp_finder and definition preview
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
    in_custom = true,
    enable = true,
    separator = ' ',
    show_file = false,
  },
}

-- local action = require("lspsaga.action")
-- -- scroll down hover doc or scroll in definition preview
-- vim.keymap.set("n", "<C-f>", function()
--   action.smart_scroll_with_saga(1)
-- end, { silent = true })
-- -- scroll up hover doc
-- vim.keymap.set("n", "<C-b>", function()
--   action.smart_scroll_with_saga(-1)
-- end, { silent = true })

-- WINBAR
-- Example:
local function get_file_name(include_path)
  local file_name = require('lspsaga.symbolwinbar').get_file_name()
  if vim.fn.bufname '%' == '' then return '' end
  if include_path == false then return file_name end
  -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
  local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
  local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%', ''), sep)
  local file_path = ''
  for _, cur in ipairs(path_list) do
    file_path = (cur == '.' or cur == '~') and '' or
        file_path .. cur .. '' .. '%#LspSagaWinbarSep#/%*' .. '%*'
  end
  return file_path .. ' ' .. file_name
end

local function config_winbar_or_statusline()
  local exclude = {
    ['teminal'] = true,
    ['toggleterm'] = true,
    ['prompt'] = true,
    ['NvimTree'] = true,
    ['lualine'] = true,
    ['help'] = true,
    ['json'] = true,
  } -- Ignore float windows and exclude filetype
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    vim.wo.winbar = ''
  else
    local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
    local sym
    if ok then sym = lspsaga.get_symbol_node() end
    local win_val = ''
    win_val = get_file_name(true) -- set to true to include path
    if sym ~= nil then win_val = win_val .. ' ' .. sym end
    vim.wo.winbar = win_val
    -- if work in statusline
    --[[ vim.wo.stl = win_val ]]
  end
end

local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }

vim.api.nvim_create_autocmd(events, {
  pattern = '*',
  callback = function() config_winbar_or_statusline() end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'LspsagaUpdateSymbol',
  callback = function() config_winbar_or_statusline() end,
})
