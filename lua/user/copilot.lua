-- require('copilot').setup({
--   panel = {
--     enabled = false,
--     auto_refresh = false,
--     keymap = {
--       jump_prev = "[[",
--       jump_next = "]]",
--       accept = "<CR>",
--       refresh = "gr",
--       open = "<M-CR>"
--     },
--     layout = {
--       position = "bottom", -- | top | left | right
--       ratio = 0.4
--     },
--   },
--   suggestion = {
--     enabled = true,
--     auto_trigger = true,
--     debounce = 75,
--     keymap = {
--       accept = false, --"<C-CR>",
--       accept_word = false,
--       accept_line = false,
--       next = "<C-]>",
--       prev = "<C-[>",
--       dismiss = "<C-\\>",
--     },
--   },
--   filetypes = {
--     yaml = false,
--     markdown = false,
--     help = false,
--     gitcommit = false,
--     gitrebase = false,
--     hgcommit = false,
--     svn = false,
--     cvs = false,
--     ["."] = false,
--   },
--   copilot_node_command = 'node', -- Node.js version must be > 16.x
--   server_opts_overrides = {},
-- })

-----------------------------------------------
-------- Co Pilot Vim -------------------------
-----------------------------------------------

-- use this table to disable/enable filetypes
vim.g.copilot_filetypes = { xml = false, yaml = false }

-- since most are enabled by default you can turn them off
-- using this table and only enable for a few filetypes
-- vim.g.copilot_filetypes = { ["*"] = false, python = true }


vim.cmd [[
 imap <silent><script><expr> <C-CR> copilot#Accept("\<CR>")
 imap <silent><script><expr> <C-]> copilot#Next("\<CR>")
]]


vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]
-- vim.g.copilot_no_tab_map = true
-- FIXME: this is not working
-- vim.keymap.set("i", "<C-l>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })

-- <C-]>                   Dismiss the current suggestion.
-- <Plug>(copilot-dismiss)
--
--                                                 *copilot-i_ALT-]*
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <Plug>(copilot-next)
--
--                                                 *copilot-i_ALT-[*
-- <M-[>                   Cycle to the previous suggestion.
-- <Plug>(copilot-previous)


