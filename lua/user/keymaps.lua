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

keymap("n", "]q", "<cmd>cnext<cr>zz", opts)
keymap("n", "[q", "<cmd>cprev<cr>zz", opts)

keymap("n", "<C-q>", ":<cr>", opts)

keymap("n", "<Enter>", ":w<cr>", opts)

keymap("n", "<C-p>", "<cmd>Telescope resume<CR>", opts)
keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)

-- Explorer
keymap("", "<C-1>", "<cmd>NvimTreeToggle<cr>", opts)
keymap("", "<C-S-1>", "<cmd>NvimTreeFocus<cr>", opts)

-- Flutter
keymap("", "<C-0>", "<cmd>lua require('flutter-tools.outline').toggle()<cr>", opts)

keymap("", "<C-2>", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

-- copy and paste
keymap("n", "<leader>p", '"0p', opts)
keymap("v", "<leader>p", '"_dP', opts)
keymap("", ";c",
  "<cmd>lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown{})<CR>", opts)

-- Clear highlights
keymap("n", "<C-n>", "<cmd>nohlsearch<CR>", opts)

-- Close Window
keymap("n", "<S-q>", "<cmd>q<CR>", opts)

-- LSP Mapping
keymap("n", "gj", "<Cmd>Lspsaga code_action<CR>", opts)
keymap("v", "gj", "<Cmd>Lspsaga code_action<CR>", opts)
-- fastaction
keymap("n", "<leader>a", "<cmd>lua require('lsp-fastaction').code_action()<CR>", opts)
keymap("v", "<leader>a", "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", opts)
-- keymap("n", "<leader>la", "<Cmd>Lspsaga code_action<CR>", opts)
-- keymap("v", "<leader>la", "<Cmd>Lspsaga code_action<CR>", opts)

-- SUBSTITUTE plugin  {{{
keymap("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
keymap("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
keymap("n", "<S-s>", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
keymap("v", "<S-s>", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
-- keymap("n", "<leader>r", "<cmd>lua require('substitute.range').operator()<cr>", { noremap = true })
keymap("x", "<leader>rr", "<cmd>lua require('substitute.range').visual()<cr>", {})
-- keymap("n", "<leader>rr", "<cmd>lua require('substitute.range').word()<cr>", {})
--}}}

-- GIT Merge
vim.keymap.set("n", "[g", "3do", { noremap = true })
vim.keymap.set("n", "]g", "1do", { noremap = true })

----------------------------------------
-- Unimpaired/Brackets Keymapping {{{

-- to do keymapping
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords
-- vim.keymap.set("n", "]t", function()
--   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
-- end, { desc = "Next error/warning todo comment" })

-- DEBUGGER {{{
keymap("n", ";b", "<CMD> lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "[d", "<CMD> lua require'dap'.step_into()<CR>", opts)
keymap("n", "]d", "<CMD> lua require'dap'.step_out()<CR>", opts)
keymap("n", "\\d", "<CMD> lua require'dap'.step_over()<CR>", opts)
-- }}}

-- Git
keymap("n", "]c", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opts)
keymap("n", "[c", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opts)

-- Harpoon
keymap("n", "]o", "<CMD>lua require('harpoon.ui').nav_next() <CR>", opts)
keymap("n", "[o", "<CMD>lua require('harpoon.ui').nav_next() <CR>", opts)

-- }}}
----------------------------------------

keymap("n", "<leader>1", "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>4", "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", opts)
keymap("n", "<leader>5", "<CMD>lua require('harpoon.ui').nav_file(5)<CR>", opts)
keymap("n", "<leader>6", "<CMD>lua require('harpoon.ui').nav_file(6)<CR>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-=>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-->", ":vertical resize +2<CR>", opts)

keymap("n", "<A-l>", "<S-l>", opts)
keymap("n", "<A-h>", "<S-h>", opts)

-- Navigate buffers
-- keymap("n", "<Tab>", ":bnext<CR>", opts)
-- keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-=>", "<C-w>=", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Buffer
keymap("n", "<leader>c", "<cmd>Bdelete!<CR>", opts)
keymap("n", "<leader>w", "<cmd>w!<CR><cmd>!tmux send-keys -t flutter 'r'<CR>", opts)
-- keymap("n", "<C-b>",
--   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{sort_mru = true, layout_config = {width = 0.6}})<cr>", opts)
keymap("n", "<leader>;",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{sort_mru = true, layout_config = {width = 0.6}})<cr>",
  opts)
keymap("n", "<leader>u",
  "<cmd>lua require('undotree').toggle()<cr>",
  opts)

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

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]
