local status_ok, flutter = pcall(require, "flutter-tools")
if not status_ok then
  return
end

flutter.setup({
  -- flutter_path = "$HOME/fvm/default", -- <-- this takes priority over the lookup
  -- flutter_path = "$HOME/flutter/bin/flutter/", -- <-- this takes priority over the lookup
  fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
  dev_log = {
    open_cmd = "tabedit",
  },
  widget_guides = {
    enabled = false,
  },
  closing_tags = {
    enabled = true, -- set to false to disable
  },
  outline = {
    open_cmd = "40vnew", -- command to use to open the outline buffer
    auto_open = false, -- if true this will open the outline automatically when it is first populated
  },
  decorations = {
    statusline = {
      app_version = false,
      device = false,
    },
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = false,
    run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
    -- register_configurations = function(_)
    -- require("dap").configurations.dart = {
    -- <put here config that you would find in .vscode/launch.json>
    -- }
    -- require("dap.ext.vscode").load_launchjs()
    -- end,
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true,
      background = false, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    on_attach = function(client, bufnr)
      -- vim.g.dart_style_guide = 2
      -- vim.g.dart_format_on_save = 1
      local istatus_ok, illuminate = pcall(require, "illuminate")
      if not istatus_ok then
        return
      end
      illuminate.on_attach(client)
    end,
    -- capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
    --- OR you can specify a function to deactivate or change or control how the config is created
    capabilities = function(config)
      return config
    end,
    settings = {
      showTodos = true,
      completeFunctionCalls = true,
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/flutter/.pub-cache"),
        vim.fn.expand("$HOME/fvm"),
        vim.fn.expand("$HOME/flutter/packages"),
      },
      renameFilesWithClasses = "prompt", -- "always"
      enableSnippets = true,
      lineLength = 2000,
    },
  },
})
