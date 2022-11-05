local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

---@diagnostic disable-next-line: unused-local
local knowunity_file_ignore = { 'pub.dartlang.org/', '.pub-cache/', 'ios/', 'windows/', 'web/', 'android/', 'assets/',
  'fonts/', 'packages/', 'doc/', 'l10n/' }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<Left>", "<C-w>h", opts)
keymap("n", "<Down>", "<C-w>j", opts)
keymap("n", "<Up>", "<C-w>k", opts)
keymap("n", "<Right>", "<C-w>l", opts)

keymap("n", "]q", "<cmd>cnext<cr>zz", opts)
keymap("n", "[q", "<cmd>cprev<cr>zz", opts)


keymap("n", "<C-Enter>", "<cmd>w!<CR><cmd>!tmux send-keys -t flutter 'r'<CR><CR>", opts)
keymap("n", "<Enter>", "<cmd>w!<CR>", opts)
keymap("n", "<C-s>", "<cmd>wa<CR>", opts)

-- TMUX Flutter
keymap("n", "ga", "<cmd>!tmux send-keys -t flutter 'r'<CR><CR>", opts)
keymap("n", "gA", "<cmd>!tmux send-keys -t flutter 'R'<CR><CR>", opts)
--[[ keymap("n", "gS", "<cmd>!tmux send-keys -t flutter 'q'<CR><CR>", opts) ]]

-- Telescope
keymap("n", "<leader>b",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, sort_mru = true})<cr>"
  , opts)
keymap("n", "<C-p>",
  "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD', debounce = 150, })<CR>", opts)

-- paste register
keymap("n", "<leader>p", '"0p', opts)
keymap("v", "<leader>p", '"_dP', opts)


-- Clear highlights
keymap("n", "<C-n>", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>q<CR>", opts)

-- LSP Mapping
keymap("n", "<leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("v", "<leader>la", ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", opts)

-- fastaction
keymap("n", "<C-j>", "<cmd>lua require('lsp-fastaction').code_action()<CR>", opts)
keymap("i", "<C-j>", "<cmd>lua require('lsp-fastaction').code_action()<CR>", opts)
keymap("v", "<C-j>", "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", opts)
keymap("n", "gl", "<cmd>lua require('lsp-fastaction').code_action()<CR>", opts)
keymap("v", "gl", "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", opts)

-- SUBSTITUTE plugin  {{{
keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
keymap("n", "<S-r>", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
keymap("v", "<S-r>", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("n", "<leader>s", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
keymap("x", "<leader>s", "<cmd>lua require('substitute.range').visual()<cr>", {})
keymap("n", "<leader>ss", "<cmd>lua require('substitute.range').word()<cr>", {})
--}}}

-- keymap("n", "<leader>r", ":%s///g<Left><Left>", {})
-- keymap("x", "<leader>r", ":s///g<Left><Left>", opts)

-- Code Navigation
-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

-- place this in one of your configuration file(s)
keymap('n', "<C-l>", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('v', "<C-l>", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
vim.keymap.set('', '<C-h>', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
vim.keymap.set('', '<C-S-h>', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-=>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-->", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts) -- does not work
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- -- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)


-- DEBUGGER {{{
--[[ keymap("n", ";b", "<CMD> lua require'dap'.toggle_breakpoint()<CR>", opts) ]]
--[[ keymap("n", "[d", "<CMD> lua require'dap'.continue()<CR>", opts) ]]

keymap("n", "[d", "<CMD> lua require'dap'.step_into()<CR>", opts)
keymap("n", "]d", "<CMD> lua require'dap'.step_out()<CR>", opts)
keymap("n", "\\d", "<CMD> lua require'dap'.step_over()<CR>", opts)

-- }}}

-- Buffer
keymap("n", "<C-k>", "<cmd>Bdelete!<CR>", opts)

keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Misc
-- keymap("n", "<F1>", ":e ~/Notes/<cr>", opts)
-- keymap("n", "<F3>", ":e .<cr>", opts)
-- keymap("n", "<F4>", "<cmd>Telescope resume<cr>", opts)
-- keymap("n", "<F5>", "<cmd>Telescope commands<CR>", opts)
-- keymap("n", "<F7>", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)
-- keymap("n", "<F8>", "<cmd>TSPlaygroundToggle<cr>", opts)
-- keymap("n", "<F11>", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- keymap("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)

keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
