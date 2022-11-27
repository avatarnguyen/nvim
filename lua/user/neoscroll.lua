local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
  return
end

event = "WinScrolled"
neoscroll.setup({
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = { '<C-y>', '<C-e>', 'zt', 'zz', 'zb' }, --'<C-u>', '<C-d>',  '<C-b>', '<C-f>',
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  use_local_scrolloff = true, -- Use the local scope of scrolloff instead of the global scope
  respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil, -- Default easing function
  pre_hook = nil, -- Function to run before the scrolling animation starts
  post_hook = nil, -- Function to run after the scrolling animation ends
})

local t = {}

--t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '50', [['sine']]}}
--t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '50', [['sine']]}}
t['zz']    = {'zz', {'80'}}
t['zt']    = {'zt', {'100'}}
t['zb']    = {'zb', {'100'}}

require('neoscroll.config').set_mappings(t)
