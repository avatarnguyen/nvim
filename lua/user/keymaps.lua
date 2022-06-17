local opts = { noremap = true, silent = true }

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

keymap("n", "<leader><leader>", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)

-- paste register
keymap("n", ",p", '"0p', opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- LSP Mapping 
-- keymap("n", "H", "<Cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor{layout_config={height=0.3, width=0.4,}})<CR>", opts)
-- keymap("n", "H", "<cmd>:lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown{})<CR>", opts)
keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
keymap("n", "gp", "<cmd>lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor{jump_type = 'never', layout_config={height=0.5, width=0.5,}})<cr><ESC>", opts)
keymap("n", "gE", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
keymap("n", "ge", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap("i", "<C-space>", "<cmd> LspSignatureHelp<CR>", opts)
keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
keymap('n', 'E', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap(
  "n", "gl",
  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)

-- Hop 
-- place this in one of your configuration file(s)
keymap('n', "<leader-n>", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('n', "<leader-m>", "<cmd>lua require'hop'.hint_words()<cr>", opts)

keymap('v', "<leader-n>", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('x', "<leader-n>", "<cmd>lua require'hop'.hint_lines()<cr>", opts)
keymap('v', "<leader-m>", "<cmd>lua require'hop'.hint_words()<cr>", opts)

keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, inclusive_jump = true })<cr>", {})
keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, inclusive_jump = true })<cr>", {})
keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})

-- Open code actions for the selected visual range
keymap("v", "<S-h>", "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", opts)
keymap("n", "<S-h>", "<cmd>lua require('lsp-fastaction').code_action()<CR>", opts)

keymap("n", "ü", "<Cmd>lua require('flutter-tools.outline').toggle()<CR>", opts)
keymap("n", "Ü", "<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown{})<cr>", opts)

-- substitute plugin
keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
keymap("n", "<S-s>", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
-- keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })

keymap("n", "<leader>s", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
keymap("x", "<leader>s", "<cmd>lua require('substitute.range').visual()<cr>", {})
keymap("n", "<leader>ss", "<cmd>lua require('substitute.range').word()<cr>", {}) 

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
-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Harpoon Plugins
keymap("n", "<A-Tab>", "<CMD> lua require('harpoon.ui').nav_next()<CR>", opts)
keymap("n", "<A-S-Tab>", "<CMD> lua require('harpoon.ui').nav_prev()<CR>", opts)
keymap("n", "<leader>1", "<CMD> lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", "<CMD> lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", "<CMD> lua require('harpoon.ui').nav_file(3)<CR>", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
