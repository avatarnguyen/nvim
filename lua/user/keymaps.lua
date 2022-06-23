local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

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
keymap("n", "<C-s>", "<cmd>w!<CR>", opts)
keymap("i", "<C-s>", "<ESC><cmd>w!<CR>", opts)
keymap("v", "<C-s>", "<cmd>w!<CR>", opts)

-- Flutter
-- s = { "<cmd>lua require('flutter-tools.commands').reload()<cr>", "Reload Flutter" },

-- NvimTree
keymap("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", opts)
keymap("x", "<leader>E", "<cmd>NvimTreeFocus<CR>", opts)


-- Telescope
keymap("n", "<leader><leader>", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{})<cr>", opts)

-- paste register
keymap("n", ",p", '"0p', opts)


-- Clear highlights
keymap("n", "<C-n>", "<cmd>nohlsearch<CR>", opts)
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- TMUX
keymap("n", "ga", "<cmd>!tmux send-keys -t flutter 'r'<CR><CR>", opts)

-- LSP Mapping
-- keymap("n", "<leader>a", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- keymap("v", "<leader>a", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- keymap("v", "<leader>lr", "<Cmd>lua require('renamer').rename()<CR>", opts)
-- keymap("n", "H", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
-- -- keymap("n", "gh", "<cmd>lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor{jump_type = 'never', layout_config={height=0.5, width=0.5,}})<cr><ESC>", opts)
-- keymap("n", "gE", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
-- keymap("n", "ge", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
-- keymap("n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- keymap("i", "<C-space>", "<cmd> LspSignatureHelp<CR>", opts)
-- keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
-- keymap('n', 'E', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- keymap(
--   "n", "gl",
--   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)

-- fastaction
keymap("v", "<S-h>", "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", opts)
keymap("n", "<S-h>", "<cmd>lua require('lsp-fastaction').code_action()<CR>", opts)

-- Hop ---
-- place this in one of your configuration file(s)
keymap('n', "<C-l>", "<cmd>lua require'hop'.hint_lines({ multi_windows = true })<cr>", opts)
keymap('v', "<C-l>", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('x', "<C-l>", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('n', "<leader>n", "<cmd>lua require'hop'.hint_words()<cr>", opts)
keymap('v', "<leader>n", "<cmd>lua require'hop'.hint_words()<cr>", opts)

keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, inclusive_jump = true })<cr>", {})
keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, inclusive_jump = true })<cr>", {})
keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})


keymap("n", "<leader>b", "<Cmd>lua require('flutter-tools.outline').toggle()<CR>", opts)
keymap("n", "<leader>o", "<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown{})<cr>", opts)

-- SUBSTITUTE plugin
-- keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
keymap("n", "<S-s>", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
keymap("n", "<leader>s", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
keymap("x", "<leader>s", "<cmd>lua require('substitute.range').visual()<cr>", {})
keymap("n", "<leader>ss", "<cmd>lua require('substitute.range').word()<cr>", {})
keymap("n", "<leader>ss", "<cmd>lua require('substitute.range').word()<cr>", {})

keymap("n", "<leader>r", ":%s///g<Left><Left>", {})
keymap("x", "<leader>r", ":s///g<Left><Left>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

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

-- Harpoon Plugins
-- keymap("n", "<A-Tab>", "<CMD> lua require('harpoon.ui').nav_next()<CR>", opts)
-- keymap("n", "<A-S-Tab>", "<CMD> lua require('harpoon.ui').nav_prev()<CR>", opts)
-- keymap("n", "<leader>1", "<CMD> lua require('harpoon.ui').nav_file(1)<CR>", opts)
-- keymap("n", "<leader>2", "<CMD> lua require('harpoon.ui').nav_file(2)<CR>", opts)
-- keymap("n", "<leader>3", "<CMD> lua require('harpoon.ui').nav_file(3)<CR>", opts)

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
