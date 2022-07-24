local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

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

-- Save
keymap("n", "<Enter>", "<cmd>w!<CR>", opts)
-- keymap("n", "<C-s>", "<cmd>w!<CR>", opts)
-- keymap("i", "<C-s>", "<ESC><cmd>w!<CR>", opts)
-- keymap("v", "<C-s>", "<cmd>w!<CR>", opts)

-- TMUX Flutter
keymap("n", "ga", "<cmd>!tmux send-keys -t flutter 'r'<CR><CR>", opts)
keymap("n", "gs", "<cmd>!tmux send-keys -t flutter 'R'<CR><CR>", opts)
-- keymap("n", "gt", ":!tmux send-keys -t flutter 'fte'", opts)
-- NvimTree
-- keymap("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", opts)
-- keymap("x", "<leader>E", "<cmd>NvimTreeFocus<CR>", opts)

-- Telescope
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)

-- paste register
keymap("n", ",p", '"0p', opts)


-- Clear highlights
keymap("n", "<C-n>", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>q<CR>", opts)

-- LSP Mapping
keymap("n", "<leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("v", "<leader>la", ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", opts)
-- fastaction
keymap("v", "<leader>a", "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", opts)
keymap("n", "<leader>a", "<cmd>lua require('lsp-fastaction').code_action()<CR>", opts)

keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap('n', 'gk', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts) -- does not seems to work
keymap('n', 'gD', '<cmd>:vsp<cr>:lua vim.lsp.buf.definition()<cr><CR>', opts)
keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
keymap("n", "gE", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
keymap("n", "ge", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap("n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap('n', '<C-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
keymap('n', 'E', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap(
  "n", "gl",
  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)

keymap('n', 'go', '<Cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>', opts)

-- Hop ---
-- place this in one of your configuration file(s)
keymap('n', "<leader>nl", "<cmd>lua require'hop'.hint_lines({ multi_windows = true })<cr>", opts)
keymap('v', "<leader>nl", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('x', "<leader>nl", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('n', "<leader>nw", "<cmd>lua require'hop'.hint_words()<cr>", opts)
keymap('v', "<leader>nw", "<cmd>lua require'hop'.hint_words()<cr>", opts)
keymap('n', "<leader>na", "<cmd>HopPattern<cr>", opts)
keymap('v', "<leader>na", "<cmd>HopPattern<cr>", opts)

keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, inclusive_jump = true })<cr>", {})
keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, inclusive_jump = true })<cr>", {})
keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})

-- SUBSTITUTE plugin  {{{
-- keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
keymap("n", "<S-s>", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
keymap("n", "<C-s>", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
keymap("x", "<C-s>", "<cmd>lua require('substitute.range').visual()<cr>", {})
keymap("n", "<leader><leader>s", "<cmd>lua require('substitute.range').word()<cr>", {})
--}}}

-- keymap("n", "<leader>r", ":%s///g<Left><Left>", {})
-- keymap("x", "<leader>r", ":s///g<Left><Left>", opts)

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

keymap("v", "p", '"_dP', opts)

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

-- Bufferline
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

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

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
