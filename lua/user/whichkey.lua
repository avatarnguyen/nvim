local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  show_help = false,
  show_keys = false,
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "-", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}


---@diagnostic disable-next-line: unused-local
local knowunity_file_ignore = { 'pub.dartlang.org/', '.pub-cache/', 'ios/', 'windows/', 'web/', 'android/', 'assets/',
  'fonts/', 'packages/', 'doc/', 'l10n/' }

local mappings = {
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["E"] = { "<cmd>NvimTreeFocus<cr>", "Explorer" },
  ["A"] = { "<cmd>wa<CR>", "Save All" },
  ["Q"] = { "<cmd>q<CR>", "Quit" },
  --[[ ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" }, ]]
  ["F"] = { "<cmd>Telescope resume<CR>", "Last Telescope command" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files({ debounce = 150, sort_last_used = true, file_ignore_patterns = {'windows/', 'web/', 'ios/', 'android/', 'fonts/', 'assets/', 'doc/'}})<cr>",
    "Find files",
  },
  ["j"] = { "<cmd>lua require('telescope.builtin').grep_string({file_ignore_patterns = {'ios/', 'android/', 'assets/', 'fonts/', 'packages/', 'doc/'}})<cr>",
    "Find String" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
  -- ["p"] = { "<cmd>:lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown{})<CR>",
  --   "Clipboard" },
  ["D"] = { "<cmd>lua require('telescope').extensions.flutter.commands()<CR>", "Flutter Commands" },
  ["M"] = { "<cmd>lua require('telescope').extensions.macroscope.default()<CR>", "Macros" },
  s = {
    name = "pickers",
    a = { "<cmd>Neotree float reveal<cr>", "File Browser" },
    j = { "<cmd>Telescope resume<CR>", "Last Picker" },
    s = {
      "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({ debounce = 150, search_dirs = 'CWD', file_ignore_patterns = knowunity_file_ignore , opts = {symbols = {'info', 'error'}}})<cr>",
      "Workspace Symbols",
    },
    -- f = { "<cmd>lua require('telescope').extensions.recent_files({ debounce = 200, workspace = 'CWD' })<CR>",
    --   "Search Recent files" },
    -- f = { "<cmd>lua require('telescope').extensions.frecency.frecency({ debounce = 200, workspace = 'CWD' })<CR>",
    --   "Search Recent files" },
    d = { "<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown{})<cr>",
      "Document Symbols" },
    l = { "<cmd>lua require('telescope.builtin').live_grep({ debounce = 200, file_ignore_patterns = {'ios/', 'android/', 'assets/', 'fonts/', 'packages/', 'doc/', 'l10n/'} })<cr>",
      "Find Text" },
    c = { "<cmd>lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown{})<CR>",
      "Clipboard" },
    m = { "<cmd>lua require('telescope').extensions.macroscope.default(require('telescope.themes').get_dropdown{})<CR>",
      "Clipboard" },
    b = { "<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{})<CR>",
      "Find in Buffer" },
    o = { "<cmd>lua require('telescope.builtin').oldfiles( { search_dirs = 'CWD' , file_ignore_patterns = {'ios/', 'android/', 'assets/', 'fonts/', 'packages/', 'doc/'} } )<cr>",
      "Open Recent File" },
    u = { "<cmd>Telescope undo<cr>",
      "Search Undo" },
  },
  -- r = {
  --   name = "Search & Replace",
  --   o = { "<cmd>lua require('substitute.range').operator()<cr>", "Substitute Range Operator" },
  --   w = { "<cmd>lua require('substitute.range').word()<cr>", "Substitute Range Word" },
  --   s =
  --   { "<CMD>SearchReplaceSingleBufferSelections<CR>", "SearchReplaceSingleBuffer [s]elction list" },
  --   a = { "<CMD>SearchReplaceSingleBufferOpen<CR>", "open" },
  --   d = { "<CMD>SearchReplaceSingleBufferCWord<CR>", "[w]ord" },
  --   W = { "<CMD>SearchReplaceSingleBufferCWORD<CR>", "[W]ORD" },
  --   e = { "<CMD>SearchReplaceSingleBufferCExpr<CR>", "[e]xpr" },
  --   f = { "<CMD>SearchReplaceSingleBufferCFile<CR>", "[f]ile" },
  -- },
  b = {
    name = "Buffer Option",
    c = { "<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true }) <cr>", "Delete all non-visible" }, -- Delete all non-visible buffers
    n = { "<cmd>lua require('close_buffers').delete({ type = 'nameless' })<cr>", "Delete all buffers without name" },
    t = { "<cmd>lua require('close_buffers').delete({ type = 'this' })<cr>", "Delete the current buffer" },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    a = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    -- e = { "<cmd>Neotree left git_status<cr>", "Git Status Tree" },
    f = { "<cmd>lua require('user.telescope').delta_git_status()<cr>", "Git Status" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff with HEAD",
    },
    h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
    o = { "<cmd>DiffviewOpen<cr>", "Open DiffView" },
    c = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
    t = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees() <cr>", "Show All Git Worktrees" },
    w = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create Git Worktree" },
  },
  l = {
    name = "LSP",
    c = { "<cmd>TSContextToggle<cr>", "Treesitter Context" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
    w = {
      "<cmd>lua require('telescope.builtin').diagnostics({file_ignore_patterns = {'windows/', 'web/'}})<cr>",
      "Workspace Diagnostics Popup",
    },
    x = {
      "<cmd>lua require('telescope.builtin').diagnostics({file_ignore_patterns = {'windows/', 'web/'}, severity = 1})<cr>",
      "Workspace Error Popup",
    },
    s = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    -- i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    --[[ r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" }, ]]
    u = { "<cmd>Trouble lsp_references<cr>", "References" },
    -- t = { "<cmd>TodoTelescope keywords=TODO,FIX<cr>", "TODO" },
    t = {
      "<cmd>lua require('telescope.builtin').diagnostics({file_ignore_patterns = {'windows/', 'web/'}, default_text = '@anh)'})<cr>",
      "Personal TODOs",
    },
  },
  o = {
    name = "Run Command",
    o = { "<cmd>OverseerToggle<cr>", "Toggle Command Window" },
    g = { "<cmd>OverseerRunCmd flutter pub get<cr>", "Run Flutter Get" },
    f = { "<cmd>OverseerRunCmd flutter pub run ota_translation && flutter pub get<cr>", "Run Flutter Translation" },
    r = { "<cmd>OverseerRunCmd flutter pub run build_runner build --delete-conflicting-outputs<cr>",
      "Run Flutter ReBuild" },
    c = { "<cmd>OverseerRunCmd flutter pub run dart_code_metrics:metrics check-unused-l10n . --class-pattern='AppLocalizations' --fatal-unused && flutter pub run dart_code_metrics:metrics check-unused-code lib --monorepo --fatal-unused<cr>", "Run App Check up" },
  },
  t = {
    name = "Run Test",
    n = { "<cmd>lua require('neotest').run.run()<cr>", "Test Nearest" },
    d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Run Test Debugger" },
    f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
    s = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop Nearest Test" },
    a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach Nearest Test" },
    l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last Test" },
    j = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", "Open Output" },
    m = { "<cmd>lua require('neotest').summary.open()<cr>", "Open Summary" },
    o = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Toggle Summary" },
  },
  S = {
    name = "Search",
    d = { "<cmd>lua require('telescope.builtin').reloader()<cr>", "Reloader", },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    K = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  m = {
    name = "Terminal",
    T = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    t = { "<cmd>lua _RUN_TRANSLATION()<cr>", "Run Flutter Translation" },
  },
  -- n = {
  --   name = "Noice",
  --   l = { "<cmd>lua require('noice').cmd('last')<cr>", "Last Command" },
  --   h = { "<cmd>lua require('noice').cmd('history')<cr>", "History" },
  --   e = { "<cmd>NoiceError<cr>", "Last Error" },
  --   f = { "<cmd>Notifications<cr>", "Noice Notifications" },
  --   t = { "<cmd>Noice telescope<cr>", "Noice Telescope" },
  --   m = { "<cmd>messages<cr>", "Last Messsages" },
  -- },
  d = {
    name = "Flutter",
    a = { ":VtrAttachToPane<CR>", "Attach Tmux" },
    j = { ":VtrSendCommandToRunner frd<CR>", "run flutter on samsung" },
    k = { ":VtrSendCommandToRunner flutter run<CR>", "run flutter default" },
    s = { ":VtrSendKeysRaw R<CR>", "Restart Flutter" },
    d = { ":VtrSendKeysRaw r<CR>", "Reload Flutter " },
    q = { ":VtrSendKeysRaw q<CR>", "Quit Flutter" },
    v = { ":VtrSendKeysRaw v<CR>", "Start Dev Tool" },
    r = { "<cmd>lua require('dart-lsp-refactorings').rename()<cr>", "Rename Dart Class" },
    l = { "<cmd>lua require('flutter-tools.devices').list_devices()<cr>", "Show Devices" },
    e = { "<cmd>lua require('flutter-tools.devices').list_emulators()<cr>", "Show Emulators" },
    g = { "<cmd>lua require('flutter-tools.commands').pub_get()<cr>", "Run Pub Get" },
    f = { "<cmd>lua require('user.lsp.handlers').code_action_fix_all()<cr><cmd>w!<cr>", "Fix All" },
    o = { "<cmd>lua require('flutter-tools.outline').toggle()<cr>", "Flutter Outlines" },
    x = { "<cmd>lua require('flutter-tools.commands').quit()<cr>", "Quit Flutter" },
    h = { "<cmd>lua require('flutter-tools.commands').run_command()<cr>", "Run" },
  },
  i = {
    name = "Session",
    l = { "<cmd>SessionManager load_session<CR>", "Load Sessions" },
    s = { "<cmd>SessionManager save_current_session<cr>", "Save current session" },
    d = { "<cmd>SessionManager load_current_dir_session<cr>", "Load current Dir session" },
  },
  h = {
    name = "Harpoon",
    a = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "Add File" },
    h = { "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle Menu" },
    l = { "<CMD>Telescope harpoon marks<CR>", "List" },
    n = { "<CMD>lua require('harpoon.ui').nav_next() <CR>", "Next" },
    b = { "<CMD>lua require('harpoon.ui').nav_prev() <CR>", "Prev" },
    ['1'] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", "Go To File 1" },
    ['2'] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", "Go To File 2" },
    ['3'] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", "Go To File 3" },
    ['4'] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", "Go To File 4" },
    ['5'] = { "<CMD>lua require('harpoon.ui').nav_file(5)<CR>", "Go To File 5" },
  },
  k = {
    name = "Debugger",
    d = { "<CMD> lua require'dap'.continue()<CR>", "Continue or Start" },
    f = { "<CMD> lua require'dap'.step_over()<CR>", "Step Over" },
    s = { "<CMD> lua require'dap'.step_out()<CR>", "Step Out" },
    a = { "<CMD> lua require'dap'.step_into()<CR>", "Step Into" },
    u = { "<CMD> lua require('dapui').toggle()<CR>", "Toggle Dap UI" },
    b = { "<CMD> lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
    t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
