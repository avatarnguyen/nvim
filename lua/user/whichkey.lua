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
  -- ["b"] = {
  --   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  --   "Buffers",
  -- },
  ["q"] = {" <Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{})<CR>", "Find in Buffer", },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["A"] = { "<cmd>w!<CR>", "Save" },
  ["Q"] = { "<cmd>q<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  -- ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{})<cr>",
    "Find files",
  }, 
  ["F"] = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Find Text" },
  ["W"] = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Find Word" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
  ["p"] = { "<cmd>:lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown{})<CR>", "Clipboard" },
  ["D"] = { "<cmd>:lua require('telescope').extensions.flutter.commands()<CR>", "Flutter Commands" },

  ["M"] = { "<cmd>:lua require('telescope').extensions.macroscope.default()<CR>", "Macros" },

  -- C = {
  --   name = "Packer",
  --   c = { "<cmd>PackerCompile<cr>", "Compile" },
  --   i = { "<cmd>PackerInstall<cr>", "Install" },
  --   s = { "<cmd>PackerSync<cr>", "Sync" },
  --   S = { "<cmd>PackerStatus<cr>", "Status" },
  --   u = { "<cmd>PackerUpdate<cr>", "Update" },
  -- },

  C = {
  -- bdelete
  name = "Close Buffer Option",
  c = { "<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true }) <cr>", "Delete all non-visible" }, -- Delete all non-visible buffers
  n = { "<cmd>lua require('close_buffers').delete({ type = 'nameless' })<cr>", "Delete all buffers without name" }, 
  t = { "<cmd>lua require('close_buffers').delete({ type = 'this' })<cr>", "Delete the current buffer" }, 

  -- bwipeout
  -- require('close_buffers').wipe({ type = 'all', force = true }) -- Wipe all buffers
  -- require('close_buffers').wipe({ type = 'other' }) -- Wipe all buffers except the current focused
  -- require('close_buffers').wipe({ type = 'hidden', glob = '*.lua' }) -- Wipe all buffers matching the glob
  },

  g = {
    name = "Git",
    e = { "<cmd>Neotree git_status<cr>", "Float Explorer" },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
    C = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
  },

  l = {
    name = "LSP",
    -- d = {
    --   "<cmd>Telescope lsp_document_diagnostics<cr>",
    --   "Document Diagnostics",
    -- },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
    e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics Float" },
    W = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics Popup",
    },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    -- u = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", "Usage" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    -- r = { "<cmd>lua require('lspsaga.rename').rename()<CR>", "Rename" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>Trouble lsp_references<cr>", "References" },
    -- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown{})<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  r = {
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

  I = {
    name = "Interface",
    b = { "<cmd>sp<CR><C-w>J20<C-w>_<cr>", "Bottom Window" },
    t = { "<cmd>vsplit<cr><cmd>split<cr>", "Triple Window" },
    c = { "<cmd>vsplit<cr><cmd>vsplit<cr>", "3 Columns" },
  },

  S = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
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
    -- R = { "<cmd>lua require('flutter-tools.commands').run_command('--flavor development --target lib/main_development.dart')<cr>", "Run Dev Flavor" },
    l = { "<cmd>lua require('flutter-tools.devices').list_devices()<cr>", "Show Devices" },
    v = { "<cmd>lua require('flutter-tools.commands').visual_debug()<cr>", "Start Visual Debugger" },
    e = { "<cmd>lua require('flutter-tools.devices').list_emulators()<cr>", "Show Emulators" },
    t = { "<cmd>lua require('flutter-tools.dev_tools').start()<cr>", "Show Dev Tools" },
    c = { "<cmd>lua require('flutter-tools.log').clear()<cr>", "Clear Logs" },
    C = { "<cmd>lua require('flutter-tools.commands').copy_profiler_url()<cr>", "Copy Profile Url" },
    h = { "<cmd>ColorHighlight<cr>", "Highlight Log" },
    p = { "<cmd>lua require('flutter-tools.commands').pub_get()<cr>", "Run Pub Get" },
    q = { "<cmd>lua require('flutter-tools.commands').quit()<cr>", "Quit Flutter" },
    s = { "<cmd>lua require('flutter-tools.commands').restart()<cr> <cmd>lua require('flutter-tools.log').clear()<cr>", "Restart Flutter" },
    S = { "<cmd>lua require('flutter-tools.commands').reload()<cr>", "Reload Flutter" },
    f = { "<cmd>lua require('telescope').extensions.flutter.fvm()<cr>", "Change Flutter Version" },
  },

  t = {
    name = "Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
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

  h = {
    name = "Harpoon",
    a = { "<CMD> lua require('harpoon.mark').add_file()<CR>", "Add File" },
    o = { "<CMD> lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle Menu" },
    h = { "<CMD> lua require('harpoon.ui').nav_file(1)<CR>", "Go To File 1" },
    j = { "<CMD> lua require('harpoon.ui').nav_file(2)<CR>", "Go To File 2" },
    k = { "<CMD> lua require('harpoon.ui').nav_file(3)<CR>", "Go To File 3" },
    l = { "<CMD> lua require('harpoon.ui').nav_file(4)<CR>", "Go To File 4" },
  },

  u = {
    name = "Debugger",
    a = { "<CMD> lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breadpoint" },
    c = { "<CMD> lua require'dap'.continue()<CR>", "Continue" },
    o = { "<CMD> lua require'dap'.step_over()<CR>", "Step Over" },
    i = { "<CMD> lua require'dap'.step_into()<CR>", "Step Into" },
    u = { "<CMD> lua require('dapui').toggle()<CR>", "Toggle Dap UI" },
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
