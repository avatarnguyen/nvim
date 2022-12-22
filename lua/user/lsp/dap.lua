local M = {}
local mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_ok then
  return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

mason_dap.setup({
  ensure_installed = {},
  automatic_setup = false,
})

mason_dap.setup_handlers {
  function(source_name)
    -- all sources with no handler get passed here
    -- Keep original functionality of `automatic_setup = true`
    require('mason-nvim-dap.automatic_setup')(source_name)
  end,
  -- python = function(source_name)
  --     dap.adapters.python = {
  --      type = "executable",
  --      command = "/usr/bin/python3",
  --      args = {
  --       "-m",
  --       "debugpy.adapter",
  --      },
  --     }
  --     dap.configurations.python = {
  --      {
  --       type = "python",
  --       request = "launch",
  --       name = "Launch file",
  --       program = "${file}", -- This configuration will launch the current file if used.
  --      },
  --     }
  -- end,
}

dap.adapters.dart = {
  type = "executable",
  command = "node",
  args = { os.getenv('HOME') .. "/.config/dap/Dart-Code/out/dist/debug.js", "flutter" }
}
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = os.getenv('HOME') .. "/flutter/bin/cache/dart-sdk/",
    flutterSdkPath = os.getenv('HOME') .. "/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  }
}
-- end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

local dap_icon = require('user.icons').dap


dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.45 },
        { id = "breakpoints", size = 0.15 },
        { id = "stacks", size = 0.35 },
        { id = "watches", size = 0.05 },
      },
      size = 60, -- columns
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.95 },
        -- { id = "console", size = 0.05 },
        -- "repl",
        -- "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = dap_icon.Pause,
      play = dap_icon.Play,
      step_into = dap_icon.Into,
      step_over = dap_icon.Over,
      step_out = dap_icon.Out,
      step_back = dap_icon.Backward,
      run_last = dap_icon.Last,
      terminate = dap_icon.Stop,
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})
--texthl = "debugBreakpoint"
vim.fn.sign_define(
  "DapBreakpoint",
  { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = " ", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = " ", texthl = "debugBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "", texthl = "debugBreakpoint", linehl = "debugPC", numhl = "" }
)

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()

end

require("nvim-dap-virtual-text").setup {
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = true, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

return M
