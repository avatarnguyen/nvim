local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
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
  show_help = true, -- show help message on the command line when the popup is visible
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

local mappings = {
  -- ["q"] = { " <Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{})<CR>",
  --   "Find in Buffer", },
  -- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  -- ["E"] = { "<cmd>NvimTreeFocus<cr>", "Explorer" },

  ["E"] = { "<cmd>Neotree reveal left<cr>", "Explorer" },
  ["e"] = { "<cmd>Neotree toggle reveal left<cr>", "Explorer" },
  ["A"] = { "<cmd>wa<CR>", "Save All" },
  ["Q"] = { "<cmd>q<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{ debounce = 150, file_ignore_patterns = {'ios/', 'android/', 'fonts/', 'assets/', 'packages/', 'doc/'}})<cr>",
    "Find files",
  },
  ["w"] = { "<cmd>lua require('telescope.builtin').grep_string({file_ignore_patterns = {'ios/', 'android/', 'assets/', 'fonts/', 'packages/', 'doc/'}})<cr>",
    "Find String" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
  ["p"] = { "<cmd>:lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown{})<CR>",
    "Clipboard" },
  ["D"] = { "<cmd>:lua require('telescope').extensions.flutter.commands()<CR>", "Flutter Commands" },

  ["M"] = { "<cmd>:lua require('telescope').extensions.macroscope.default()<CR>", "Macros" },


  s = {
    name = "pickers",
    a = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{search_dirs = { '~/Developer/app-flutter/assets/' }})<cr>",
      "Find Assets",
    },
    h = {
      "<cmd>lua require('telescope.builtin').find_files({search_dirs = { '~/Developer/app-flutter/lib/constants/' }})<cr>",
      "Find App Constants",
    },
    t = {
      "<cmd>lua require('telescope.builtin').find_files({ search_dirs = { '~/Developer/app-flutter/lib/constants/app_theme.dart' }})<cr>",
      "Find App Theme",
    },
    e = { "<cmd>Neotree reveal float<cr>", "Float Explorer" },
    -- o, f, g occupied by snap
    -- f = {
    --   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{debounce = 150, search_dirs = { '~/Developer/app-flutter/lib/' }, file_ignore_patterns = {'l10n/'}})<cr>",
    --   "Find files in lib",
    -- },
    -- l = { "<cmd>lua require('telescope.builtin').live_grep({ debounce = 300, file_ignore_patterns = {'ios/', 'android/', 'assets/', 'fonts/', 'packages/', 'doc/', 'l10n/'} })<cr>",
    --   "Find Text" },
    c = { "<cmd>lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown{})<CR>",
      "Clipboard" },
    b = { " <Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{})<CR>",
      "Find in Buffer" },
  },

  o = {
    name = "Outlines",
    o = { "<cmd>lua require('flutter-tools.outline').toggle()<cr>", "Flutter Outlines" },
    d = { "<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown{})<cr>",
      "Document Symbols" },
    w = {
      "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({ debounce = 150 })<cr>",
      "Workspace Symbols",
    },
  },

  C = {
    -- bdelete
    name = "Close Buffer Option",
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
    e = { "<cmd>Neotree left git_status<cr>", "Git Status Tree" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
    C = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
    t = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees() <cr>", "Show All Git Worktrees" },
    w = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Add Git Worktree" },
  },

  l = {
    name = "LSP",
    c = { "<cmd>TSContextToggle<cr>", "Treesitter Context" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
    e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics Float" },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics Popup",
    },
    W = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua require('renamer').rename()<cr>", "Rename" },
    R = { "<cmd>Trouble lsp_references<cr>", "References" },
  },

  t = {
    name = "Run Test",
    r = { "<cmd>TestNearest<cr>", "Test Nearest" },
    f = { "<cmd>TestFile<cr>", "Test File" },
    s = { "<cmd>TestSuite<cr>", "Test Suite" },
    l = { "<cmd>TestLast<cr>", "Rerun Last Test" },
    v = { "<cmd>TestVisit<cr>", "Test Visit" },
    u = { "<cmd>Ultest<cr>", "Run Ultest" },
    o = { "<cmd>UltestSummary<cr>", "Toggle Summary" },
    n = { "<cmd>UltestNearest<cr>", "Run Ultest Nearest" },
  },

  S = {
    name = "Search",
    d = { "<cmd>lua require('telescope.builtin').reloader()<cr>", "Reloader", },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    K = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  T = {
    name = "Terminal",
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

  d = {
    name = "Flutter",
    d = { "<cmd>lua require('flutter-tools.commands').run_command()<cr>", "Run" },
    D = { "<cmd>lua require('flutter-tools.commands').run_command('--profile')<cr>", "Run Profile Mode" },
    r = { "<cmd>lua require('flutter-tools.commands').run_command('--flavor dev --debug')<cr>", "Run Dev Flavor" },
    l = { "<cmd>lua require('flutter-tools.devices').list_devices()<cr>", "Show Devices" },
    v = { "<cmd>lua require('flutter-tools.commands').visual_debug()<cr>", "Start Visual Debugger" },
    e = { "<cmd>lua require('flutter-tools.devices').list_emulators()<cr>", "Show Emulators" },
    t = { "<cmd>lua require('flutter-tools.dev_tools').start()<cr>", "Show Dev Tools" },
    c = { "<cmd>lua require('flutter-tools.log').clear()<cr>", "Clear Logs" },
    C = { "<cmd>lua require('flutter-tools.commands').copy_profiler_url()<cr>", "Copy Profile Url" },
    -- h = { "<cmd>ColorHighlight<cr>", "Highlight Log" },
    p = { "<cmd>lua require('flutter-tools.commands').pub_get()<cr>", "Run Pub Get" },
    q = { "<cmd>lua require('flutter-tools.commands').quit()<cr>", "Quit Flutter" },
    S = { "<cmd>lua require('flutter-tools.commands').restart()<cr> <cmd>lua require('flutter-tools.log').clear()<cr>",
      "Restart Flutter" },
    s = { "<cmd>lua require('flutter-tools.commands').reload()<cr>", "Reload Flutter" },
    f = { "<cmd>lua require('telescope').extensions.flutter.fvm()<cr>", "Change Flutter Version" },
  },

  x = {
    name = "Trouble",
    r = { "<cmd>Trouble references<cr>", "References" },
    f = { "<cmd>Trouble definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  },

  i = {
    name = "Session",
    l = { "<cmd>SessionManager load_session<CR>", "Load Sessions" },
    s = { "<cmd>SessionManager save_current_session<cr>", "Save current session" },
    d = { "<cmd>SessionManager load_current_dir_session<cr>", "Load current Dir session" },
  },

  m = {
    name = "Plantuml",
    o = { "<cmd>PlantumlOpen<CR>", "Open UML" },
    s = { "<cmd>PlantumlSave ", "Save Diagram" },
  },

  h = {
    name = "Harpoon",
    a = { "<CMD>lua require('harpoon.mark').add_file()<CR>", "Add File" },
    h = { "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle Menu" },
    l = { "<CMD>Telescope harpoon marks<CR>", "List" },
    ['1'] = { "<CMD>lua require('harpoon.ui').nav_file(1)<CR>", "Go To File 1" },
    ['2'] = { "<CMD>lua require('harpoon.ui').nav_file(2)<CR>", "Go To File 2" },
    ['3'] = { "<CMD>lua require('harpoon.ui').nav_file(3)<CR>", "Go To File 3" },
    ['4'] = { "<CMD>lua require('harpoon.ui').nav_file(4)<CR>", "Go To File 4" },
    ['5'] = { "<CMD>lua require('harpoon.ui').nav_file(5)<CR>", "Go To File 5" },
  },

  u = {
    name = "Debugger",
    a = { "<CMD> lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breadpoint" },
    c = { "<CMD> lua require'dap'.continue()<CR>", "Continue" },
    o = { "<CMD> lua require'dap'.step_over()<CR>", "Step Over" },
    O = { "<CMD> lua require'dap'.step_out()<CR>", "Step Out" },
    i = { "<CMD> lua require'dap'.step_into()<CR>", "Step Into" },
    u = { "<CMD> lua require('dapui').toggle()<CR>", "Toggle Dap UI" },
    b = { "<CMD> lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
    t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
